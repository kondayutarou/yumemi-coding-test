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
    @IBOutlet weak var searchBar: UISearchBar!

    var cancellableSet: Set<AnyCancellable> = []
    var githubRepositoryList: [GithubRepositoryListItemResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        let cell = UITableViewCell()
        let repositoryItem = githubRepositoryList[indexPath.row]
        cell.textLabel?.text = repositoryItem.fullName
        cell.detailTextLabel?.text = repositoryItem.language
        cell.tag = indexPath.row
        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedIndex = indexPath.row
        let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? DetailsViewController else {
            return
        }
        viewController.apiResponse = githubRepositoryList[tappedIndex]
        store.dispatch(.githubRepository(.fetchAvatarImage(index: tappedIndex)))
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text, word.count > 0 else { return }

        store.dispatch(.githubRepository(.fetchGithubRepositoryList(query: word)))
    }
}
