//
//  SearchViewController.swift
//  MovieBrowser
//
//  Created by Ranjith on 10/18/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

    var viewModel: SearchViewModel
    var spinnerView: SpinnerViewController?

    @IBOutlet private weak var resultsTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private var bag = Set<AnyCancellable>()


    // MARK: - Dependencies

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: SearchViewController.self), bundle: Bundle.main)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        bindViewModel()
        registerCell()
        self.title = "Movie Search"
      
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.prefersLargeTitles = true

            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBlue
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func bindViewModel() {
        viewModel.errorPublisher.sink {  _ in
        }.store(in: &bag)

        viewModel.update.sink { [weak self] in
            self?.resultsTableView.reloadData()
        }.store(in: &bag)

        viewModel.spinnerVisible.sink { [weak self] state in
            self?.changeSpinnerState(state: state)
            self?.resultsTableView.reloadData()
        }.store(in: &bag)
    }

    private func changeSpinnerState(state: Bool) {
        if state {
            spinnerView = SpinnerViewController()
            if let spinner = spinnerView {
                createSpinnerView(child: spinner)
            }
        } else {
            if let spinner = spinnerView {
                hideSpinnerView(child: spinner)
                spinnerView = nil
            }
        }

    }

    private func registerCell() {
        resultsTableView.register(SearchResultTableViewCell.nib, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
    }

    

    @IBAction func goButtonTapped(_ sender: UIButton) {
        searchBarSearchButtonClicked(searchBar)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieModel?.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier)  as? SearchResultTableViewCell else {
            fatalError()
        }
        if let results = viewModel.movieModel?.results{
            cell.result = results[indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetail(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    private func navigateToDetail(indexPath: IndexPath) {
        guard let results = viewModel.movieModel?.results else { return }
        let viewModel = MovieDetailViewModel(result: results[indexPath.row])
        let vc = MovieDetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text else {
            return
        }
        viewModel.getSearchData(searchText: text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
