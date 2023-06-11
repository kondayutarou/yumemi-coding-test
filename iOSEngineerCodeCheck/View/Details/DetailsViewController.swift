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
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!

    private(set) var viewData: GithubRepositoryListItemResponse!
    var cancellableSet: Set<AnyCancellable> = []

    static func make(viewData: GithubRepositoryListItemResponse) -> DetailsViewController? {
        guard let viewController = R.storyboard.detailsViewController.instantiateInitialViewController()
        else { return nil }

        viewController.viewData = viewData
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let language = viewData.language {
            languageLabel.text = "Written in \(language)"
        } else {
            languageLabel.isHidden = true
        }
        starsLabel.text = "\(viewData.stargazersCount) stars"
        watchersLabel.text = "\(viewData.watchersCount) watchers"
        forksLabel.text = "\(viewData.forksCount) forks"
        issuesLabel.text = "\(viewData.openIssuesCount) open issues"
        titleLabel.text = viewData.fullName
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        subscribeToStore()
    }

    override func viewWillDisappear(_ animated: Bool) {
        cancellableSet.removeAll()
        super.viewWillDisappear(animated)
    }
}
