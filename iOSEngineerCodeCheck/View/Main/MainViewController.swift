//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Combine

final class MainViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!

    var cancellableSet: Set<AnyCancellable> = []
    var githubRepositoryList: [GithubRepositoryListItemResponse] = []

    var word: String!
    var url: String!
    var idx: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToStore()
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        word = searchBar.text!

        if word.count != 0 {
            store.dispatch(.githubRepository(.fetchGithubRepositoryList(query: word)))
        }
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
        // 画面遷移時に呼ばれる
        idx = indexPath.row
        let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? DetailsViewController else {
            return
        }
        viewController.apiResponse = githubRepositoryList[idx]
        store.dispatch(.githubRepository(.fetchAvatarImage(index: idx)))
        navigationController?.pushViewController(viewController, animated: false)
    }
}
