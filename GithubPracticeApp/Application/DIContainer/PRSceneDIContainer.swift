//
//  PullRequestsDIContainer.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import UIKit

final class PRSceneDIContainer {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeSearchPRsUseCase() -> GetPullRequestsUseCase {
        return DefaultPullRequestUseCase(fetchManager: makePrFetchManager())
    }
    
    // MARK: - Data Fetch Manager
    func makePrFetchManager() -> PullRequestsFetchManager {
        return DefaultPRFetchManager(dataTransferService: dependencies.apiDataTransferService)
    }
    
    func makeImageFetchManager() -> ImageRequestFetchManager? {
        return nil
    }
    
    // MARK: - Pull Request List
    func makePRListViewController() -> PRListViewController {
        return PRListViewController.create(with: makePrFetchListViewModel(), imageManager: makeImageFetchManager())
    }
    
    func makePrFetchListViewModel() -> PRListViewModel {
        return DefaultPRListViewModel(prFetchUseCase: makeSearchPRsUseCase())
    }
    
    // MARK: - Flow Coordinators
    func makePRSearchFlowCoordinator(navigationController: UINavigationController) -> PRListFlowCoordinator {
        return PRListFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
    
    
}

extension PRSceneDIContainer: PRSearchFlowCoordinatorDependencies {}
