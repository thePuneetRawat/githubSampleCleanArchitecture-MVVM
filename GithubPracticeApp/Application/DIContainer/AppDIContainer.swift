//
//  DIContainer.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
                                          queryParameters: ["state": "closed"])
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
//    // MARK: - DIContainers of scenes
//    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
//        let dependencies = MoviesSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService,
//                                                               imageDataTransferService: imageDataTransferService)
//        return MoviesSceneDIContainer(dependencies: dependencies)
//    }
}
