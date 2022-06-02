//
//  AppFlowCoordinator.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let prSceneDIContainer = appDIContainer.makePrSceneDIContainer()
        let flow = prSceneDIContainer.makePRSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
