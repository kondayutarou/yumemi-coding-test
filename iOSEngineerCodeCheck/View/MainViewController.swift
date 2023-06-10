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

    private var apiResponse: [GithubRepositoryListItemResponse] = []

    var task: URLSessionTask?
    var word: String!
    var url: String!
    var idx: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        word = searchBar.text!

        if word.count != 0 {
            url = "https://api.github.com/search/repositories?q=\(word!)"
            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, _) in
                guard let data else {return }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(GithubRepositoryListResponse.self, from: data)
                    self.apiResponse = response.items
                } catch let jsonError as NSError {
                    print(jsonError)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResponse.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        let repositoryItem = apiResponse[indexPath.row]
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
        // TODO: ViewControllerを渡さない
        viewController.apiResponse = apiResponse[idx]
        navigationController?.pushViewController(viewController, animated: false)
    }
}
