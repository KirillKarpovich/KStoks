//
//  ViewController.swift
//  KStocks
//
//  Created by Kirill Karpovich on 13.02.23.
//

import UIKit
import FloatingPanel

class WatchListViewController: UIViewController {
    
    private var searchTimer: Timer?
    
    private var panel: FloatingPanelController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSearchController()
        setupFloationgPanel()
        setupTitleView()
    }
    
    private func setupFloationgPanel() {
        let vc = TopStoriesNewsViewController()
        let panel = FloatingPanelController()
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.addPanel(toParent: self)
        panel.delegate = self
        panel.track(scrollView: vc.tableView)
    }
    
    
    private func setupTitleView() {
        let titleView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: navigationController?.navigationBar.height ?? 100
            )
        )
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width-20, height: titleView.height))
        label.text = "Stocks"
        titleView.addSubview(label)
        label.font = .systemFont(ofSize: 40, weight: .bold)
        navigationItem.titleView = titleView
    }
    
    private func setupSearchController() {
        let resultVC = SearchResultsViewController()
        resultVC.delegate = self
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
}

extension WatchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultVC = searchController.searchResultsController as? SearchResultsViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            APIManager.shared.search(query: query) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        resultVC.update(with: response.result)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        resultVC.update(with: [])
                    }
                    print(error.localizedDescription)
                }
            }
        })
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate {
    func SearchResultsViewControllerDidSelect(searchResult: SearchResult) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
        let vc = StockDetailViewController()
        let navVC = UINavigationController(rootViewController: vc)
        vc.title = searchResult.description
        present(navVC, animated: true)
    }
}

extension WatchListViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        navigationItem.titleView?.isHidden = fpc.state == .full
    }
}
