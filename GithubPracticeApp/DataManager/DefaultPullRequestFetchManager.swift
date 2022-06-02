//
//  DefaultPullRequestFetchManager.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 08/05/22.
//

import Foundation

final class DefaultPRFetchManager {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultPRFetchManager: PullRequestsFetchManager {
    func fetchPullRequestsList(queryRequestValue: GetPullRequestUseCaseRequestValue, completion: @escaping (Result<[PullRequest], Error>) -> Void) -> Cancellable? {
        
        let task = ManagerTask()
        
        let requestDataQuery = PrDataRequestObject(user: queryRequestValue.query.username, repo: queryRequestValue.query.repository, queryParam: PRDataQuery(state: queryRequestValue.query.pullRequestType.rawValue))
        
        let endpoint = APIEndpoints.getPRs(with: requestDataQuery)
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return task
    }
}
