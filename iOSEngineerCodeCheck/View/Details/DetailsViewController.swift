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

    var viewData: GithubRepositoryListItemResponse!
    var cancellableSet: Set<AnyCancellable> = []

    static func make(viewData: GithubRepositoryListItemResponse) -> DetailsViewController? {
        let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? DetailsViewController else {
            return nil
        }
        viewController.viewData = viewData
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        languageLabel.text = "Written in \(viewData.language ?? "")"
        starsLabel.text = "\(viewData.stargazersCount) stars"
        watchersLabel.text = "\(viewData.watchersCount) watchers"
        forksLabel.text = "\(viewData.forksCount) forks"
        issuesLabel.text = "\(viewData.openIssuesCount) open issues"
        titleLabel.text = viewData.fullName
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
