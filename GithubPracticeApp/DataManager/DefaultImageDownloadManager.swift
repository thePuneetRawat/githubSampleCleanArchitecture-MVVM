//
//  DefaultImageDownloadManager.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 08/05/22.
//

import Foundation

final class DefaultImagesManager {
    
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultImagesManager: ImageRequestFetchManager {
    func fetchImage(with imagePath: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        let endpoint = APIEndpoints.getAvatarImage(path: imagePath)
        let task = ManagerTask()
        task.networkTask = dataTransferService.request(with: endpoint) { (result: Result<Data, DataTransferError>) in
            let result = result.mapError { $0 as Error }
            DispatchQueue.main.async { completion(result) }
        }
        return task
    }
}
