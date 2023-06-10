//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Combine

final class DetailsViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!

    var apiResponse: GithubRepositoryListItemResponse!
    var cancellableSet: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        languageLabel.text = "Written in \(apiResponse.language ?? "")"
        starsLabel.text = "\(apiResponse.stargazersCount) stars"
        watchersLabel.text = "\(apiResponse.watchersCount) watchers"
        forksLabel.text = "\(apiResponse.forksCount) forks"
        issuesLabel.text = "\(apiResponse.openIssuesCount) open issues"
        titleLabel.text = apiResponse.fullName
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToStore()
    }

    override func viewWillDisappear(_ animated: Bool) {
        cancellableSet.removeAll()
        super.viewWillDisappear(animated)
    }
}
