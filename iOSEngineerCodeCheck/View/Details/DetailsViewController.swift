//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class DetailsViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!

    var apiResponse: GithubRepositoryListItemResponse!

    override func viewDidLoad() {
        super.viewDidLoad()

//        languageLabel.text = "Written in \(apiResponse.language ?? "")"
//        starsLabel.text = "\(apiResponse.stargazersCount) stars"
//        watchersLabel.text = "\(apiResponse.watchersCount) watchers"
//        forksLabel.text = "\(apiResponse.forksCount) forks"
//        issuesLabel.text = "\(apiResponse.openIssuesCount) open issues"
        getImage()

    }

    func getImage() {
//        titleLabel.text = apiResponse.fullName
//
//        guard let owner = apiResponse.owner else {
//            return
//        }
//        let imgURL = owner.avatarURL
//        URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, _, _) in
//            let img = UIImage(data: data!)!
//            DispatchQueue.main.async {
//                self.avatarImageView.image = img
//            }
//        }.resume()
    }
}
