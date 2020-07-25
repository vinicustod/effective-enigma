//
//  ListController.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol ListRepositoriesDisplayLogic: class {
    func showRepositories(_ viewModel: ListRepositories.LoadPage.ViewModel)
    func showError(_ error: Error)

    func showRepoPullRequests()
}

final class ListRepositoriesController: UIViewController {

    var interactor: ListRepositoriesBusinessLogic?
    var router: (ListRepositoriesRoutingLogic & ListRepositoriesDataPassing)?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
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
        let interactor = ListRepositoriesInteractor()
        let presenter = ListRepositoriesPresenter()
        let worker = ListRepositoriesWorker(githubAPI: GithubService())
        let router = ListRepositoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    var currentDisplayingPage: Int = 1
    var displayableRepositories: [Repository] = []
    var isLoading: Bool = false
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoading = true
        interactor?.loadRepositories(ListRepositories.LoadPage.Request(currentPage: currentDisplayingPage))
    }

}

extension ListRepositoriesController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.displayableRepositories.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as? RepositoryCell else {
                return UITableViewCell()
            }

            cell.repository = self.displayableRepositories[indexPath.row]

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell") as? LoadingCell else {
                return UITableViewCell()
            }

            cell.setLoading(self.isLoading)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        interactor?.didSelectRepository(at: indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            isLoading = true
            currentDisplayingPage += 1
            interactor?.loadRepositories(ListRepositories.LoadPage.Request(currentPage: currentDisplayingPage))
        }
    }
}

extension ListRepositoriesController: ListRepositoriesDisplayLogic {
    func showRepositories(_ viewModel: ListRepositories.LoadPage.ViewModel) {
        self.isLoading = false
        displayableRepositories.append(contentsOf: viewModel.repositories)
        tableView.reloadData()
    }

    func showError(_ error: Error) {
        self.isLoading = false
        if displayableRepositories.count == 0 {
            self.showAlert(error)
        }
    }

    func showAlert(_ error: Error) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { _ in
            self.interactor?.loadRepositories(ListRepositories.LoadPage.Request(currentPage: self.currentDisplayingPage))
        }))


        self.present(alert, animated: true, completion: nil)
    }

    func showRepoPullRequests() {
        router?.routeToRepoPullRequests()
    }


}
