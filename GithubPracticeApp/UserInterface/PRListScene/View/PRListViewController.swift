//
//  PRListViewController.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 08/05/22.
//

import UIKit

class PRListViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet weak var emptyDataLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var searchActionsContainer: UIView!
    @IBOutlet weak var prListContainer: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var prStateListButton: UIButton!
    @IBOutlet weak var repositoryTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    private var viewModel: PRListViewModel!
    private var prListTableViewController: PRListTableViewController?
    
    private var prSearchState: PullRequestType? = .closed

    private var imageLoadManager: ImageRequestFetchManager?
    
    // MARK: - Lifecycle

    static func create(with viewModel: PRListViewModel, imageManager: ImageRequestFetchManager?) -> PRListViewController {
        let view = PRListViewController.instantiateViewController()
        view.viewModel = viewModel
        view.imageLoadManager = imageManager
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBehaviours()
        setupViews()
        setupStateButton()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: PRListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.query.observe(on: self) { [weak self] in self?.updateSearchQuery($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    //MARK: - Private
    
    private func setupViews() {
        emptyDataLabel.text = viewModel.emptyDataTitle
    }
    
    private func setupBehaviours() {
        addBehaviors([HideNavigationBarBehavior()])
    }
    
    private func updateItems() {
        prListTableViewController?.reload()
    }
    
    private func updateLoading(_ loading: Bool) {
        emptyDataLabel.isHidden = true
        contentView.isHidden = true
        LoadingView.hide()
        
        if loading {
            LoadingView.show()
        } else {
            contentView.isHidden = viewModel.isEmpty
            emptyDataLabel.isHidden = !viewModel.isEmpty
        }

        prListTableViewController?.updateLoading(loading: loading)
    }
    
    private func setupStateButton() {
        
        var actions = [UIAction]()
        
        PullRequestType.allCases.forEach {[unowned self] state in
            let action = UIAction(title: state.rawValue) { _ in
                self.updateState(state: state)
            }
            actions.append(action)
        }
        
        let menu = UIMenu(title: "Select PR type", options: .displayInline, children: actions)
        
        prStateListButton.menu = menu
        prStateListButton.setTitle(PullRequestType.closed.rawValue, for: .normal)
    }
    
    private func updateState(state: PullRequestType) {
        prStateListButton.setTitle(state.rawValue, for: .normal)
        self.prSearchState = state
        searchParametersChanged()
    }
    

    @IBAction func searchAction(_ sender: Any) {
        searchParametersChanged()
    }
    
    private func searchParametersChanged() {
        guard let user = usernameTextField.text, let repo = repositoryTextField.text , !user.isEmpty, !repo.isEmpty else {
            return
        }
        viewModel.didSearch(repo: repo, owner: user, prType: self.prSearchState)
    }

    private func updateSearchQuery(_ query: PullRequestQuery) {
        usernameTextField.resignFirstResponder()
        usernameTextField.text = query.username
        repositoryTextField.resignFirstResponder()
        repositoryTextField.text = query.repository
        prStateListButton.setTitle( query.pullRequestType.rawValue, for: .normal)
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: PRListTableViewController.self),
            let destinationVC = segue.destination as? PRListTableViewController {
            prListTableViewController = destinationVC
            prListTableViewController?.viewModel = viewModel
            prListTableViewController?.imageLoadManager = imageLoadManager
        }
    }
    
}
