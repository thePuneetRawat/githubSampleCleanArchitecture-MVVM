//
//  SearchPullRequestsUseCase.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation

protocol GetPullRequestsUseCase {
    func execute(requestValue: GetPullRequestUseCaseRequestValue,
                 completion: @escaping (Result<[PullRequest], Error>) -> Void) -> Cancellable?
}


final class DefaultPullRequestUseCase: GetPullRequestsUseCase {
    
    private let prFetchManager: PullRequestsFetchManager
    
    init(fetchManager: PullRequestsFetchManager) {
        self.prFetchManager = fetchManager
    }

    func execute(requestValue: GetPullRequestUseCaseRequestValue, completion: @escaping (Result<[PullRequest], Error>) -> Void) -> Cancellable? {
        return prFetchManager.fetchPullRequestsList(queryRequestValue: requestValue, completion: completion)
    }    
}


struct GetPullRequestUseCaseRequestValue {
    let query: PullRequestQuery
    let page: Int
}
