//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class MainViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!

    private var viewState: MainViewControllerState?

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
        viewState = MainViewControllerState()
        viewState?.viewController = self
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
        viewState = nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState?.githubRepositoryList.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let repositoryItem = viewState?.githubRepositoryList[indexPath.row] else { return cell }
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
        viewController.apiResponse = viewState?.githubRepositoryList[idx]
        store.dispatch(.githubRepository(.fetchAvatarImage(index: idx)))
        navigationController?.pushViewController(viewController, animated: false)
    }
}
