//
//  RepoPullRequestsController.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 23/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol RepoPullRequestsDisplayLogic: class {
    func showPullRequests(_ viewModel: RepoPullRequests.LoadPullRequests.ViewModel)
    func showError(_ error: Error)
}

final class RepoPullRequestsController: UIViewController {

    var interactor: RepoPullRequestsBusinessLogic?
    var router: (RepoPullRequestsRoutingLogic & RepoPullRequestsDataPassing)?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = RepoPullRequestsInteractor()
        let presenter = RepoPullRequestsPresenter()
        let worker = RepoPullRequestsWorker(githubAPI: GithubService())
        let router = RepoPullRequestsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        interactor?.loadPullRequests(RepoPullRequests.LoadPullRequests.Request())
    }

    var displayablePullRequests:[PullRequest] = []
}

extension RepoPullRequestsController: RepoPullRequestsDisplayLogic {
    func showError(_ error: Error) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.router?.dismiss()
        }))

        alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in
            self.interactor?.loadPullRequests(RepoPullRequests.LoadPullRequests.Request())
        }))


        self.present(alert, animated: true, completion: nil)
    }

    func showPullRequests(_ viewModel: RepoPullRequests.LoadPullRequests.ViewModel) {
        displayablePullRequests = viewModel.pullRequests
        tableView.reloadData()
    }


}

extension RepoPullRequestsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayablePullRequests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryPullRequestsCell") as? RepositoryPullRequestsCell else {
            return UITableViewCell()
        }

        cell.pullRequest = displayablePullRequests[indexPath.row]

        return cell
    }
}
