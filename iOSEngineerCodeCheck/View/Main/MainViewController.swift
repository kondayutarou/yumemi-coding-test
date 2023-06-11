//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Combine

final class MainViewController: UITableViewController {
    @IBOutlet private weak var searchBar: UISearchBar!

    var cancellableSet: Set<AnyCancellable> = []
    var githubRepositoryList: [GithubRepositoryListItemResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: RepositoryCell.cellIdentifier
        )
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        subscribeToStore()
    }

    override func viewWillDisappear(_ animated: Bool) {
        cancellableSet.removeAll()
        super.viewWillDisappear(animated)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubRepositoryList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.cellIdentifier, for: indexPath)
            as? RepositoryCell {
            let repositoryItem = githubRepositoryList[indexPath.row]
            if let language = repositoryItem.language {
                cell.languageLabel.text = language
            } else {
                cell.languageLabel.isHidden = true
            }
            cell.titleLabel.text = repositoryItem.fullName
            return cell
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedIndex = indexPath.row
        guard let viewController = DetailsViewController.make(
            viewData: store.state.githubRepositoryState.repositoryList[tappedIndex]
        ) else {
            return
        }
        store.dispatch(.githubRepository(.fetchAvatarImage(index: tappedIndex)))
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text, word.count > 0 else { return }

        store.dispatch(.githubRepository(.fetchGithubRepositoryList(query: word)))
        view.endEditing(true)
    }
}
