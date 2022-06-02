//
//  PRFetchFlowCoordinator.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import UIKit

protocol PRSearchFlowCoordinatorDependencies  {
    func makePRListViewController() -> PRListViewController
}

final class PRListFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: PRSearchFlowCoordinatorDependencies
    
    private weak var prListVC: PRListViewController?

    init(navigationController: UINavigationController,
         dependencies: PRSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makePRListViewController()
        navigationController?.pushViewController(vc, animated: true)
        prListVC = vc
    }
}
