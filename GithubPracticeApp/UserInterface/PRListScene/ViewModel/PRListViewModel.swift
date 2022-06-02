//
//  PRListViewModel.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation


protocol PRListViewModelInput {
    func viewDidLoad()
    func didSearch(repo: String?, owner: String?, prType: PullRequestType?)
}


protocol PRListViewModelOutput {
    var items: Observable<[PullRequestViewModel]> { get } /// Also we can calculate view model items on demand:  https://github.com/kudoleh/iOS-Clean-Architecture-MVVM/pull/10/files
    var owner: Observable<String> { get }
    var repo: Observable<String> { get }
    var error: Observable<String> { get }
    var query: Observable<PullRequestQuery> {get}
    var loading: Observable<Bool> {get}
    var isEmpty: Bool { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var ownertextPlaceholder: String { get }
    var repotextPlaceholder: String { get }
}


protocol PRListViewModel: PRListViewModelInput, PRListViewModelOutput {}

final class DefaultPRListViewModel: PRListViewModel {
    
    private let prListUseCase: GetPullRequestsUseCase
    
    var currentPage: Int = 0
    
    private var prListTask : Cancellable? {
        willSet {
            prListTask?.cancel()
        }
    }
    
    
    //MARK: - OUTPUT
    
    var items: Observable<[PullRequestViewModel]> = Observable([])
        
    var owner: Observable<String> = Observable("")
    
    var repo: Observable<String> = Observable("")
    
    var error: Observable<String> = Observable("")
    
    var loading: Observable<Bool> = Observable(false)
    
    var query: Observable<PullRequestQuery> = Observable(.init(repository: "lottie-ios", username: "airbnb", pullRequestType: .closed))
    
    var isEmpty: Bool { return items.value.isEmpty}
    
    var screenTitle: String = NSLocalizedString( "Pull Requests", comment: "")
    
    var emptyDataTitle: String = NSLocalizedString( "Pull Requests", comment: "")
    
    var errorTitle: String = NSLocalizedString( "Error", comment: "")
    
    var ownertextPlaceholder: String = NSLocalizedString( "Repo Owner", comment: "")
    
    var repotextPlaceholder: String = NSLocalizedString( "Repo Name", comment: "")
    
    //MARK: - Init
    
    init(prFetchUseCase: GetPullRequestsUseCase) {
        self.prListUseCase = prFetchUseCase
    }
    
    //MARK: - Private
    
    private func reloadPage(_ prList: [PullRequest]) {
        items.value = prList.map(PullRequestViewModel.init)
    }
    
    private func resetPages() {
        currentPage = 0
        items.value.removeAll()
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading Pull Requests", comment: "")
    }
    
    private func load(prQuery: PullRequestQuery) {
        self.loading.value = true
        query.value = prQuery

        prListTask = prListUseCase.execute(
            requestValue: .init(query: prQuery, page: 0),
            completion: { result in
                switch result {
                case .success(let prList):
                    self.reloadPage(prList)
                case .failure(let error):
                    self.handle(error: error)
                }
                self.loading.value = false
        })
    }
    
    private func update(prQuery: PullRequestQuery) {
        resetPages()
        load(prQuery: prQuery)
    }
    
}

extension DefaultPRListViewModel {
    
    func viewDidLoad() {}
    
    func didSearch(repo: String?, owner: String?, prType: PullRequestType?) {
        guard let repo = repo, let owner = owner, !repo.isEmpty, !owner.isEmpty else {
            return
        }
        update(prQuery: PullRequestQuery(repository: repo, username: owner, pullRequestType: prType ?? .closed))
    }
}
