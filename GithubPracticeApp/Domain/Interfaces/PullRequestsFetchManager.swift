//
//  PullRequestsNetworkManager.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation

protocol PullRequestsFetchManager {
    @discardableResult
    func fetchPullRequestsList(queryRequestValue: GetPullRequestUseCaseRequestValue,
                               completion: @escaping (Result<[PullRequest],
                                                      Error>) -> Void) -> Cancellable?
}
