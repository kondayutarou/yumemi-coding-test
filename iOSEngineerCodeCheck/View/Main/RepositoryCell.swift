//
//  RepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

final class RepositoryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!

    func updateCell(viewData: GithubRepositoryListItemResponse) {
        if let language = viewData.language {
            languageLabel.text = language
        } else {
            languageLabel.isHidden = true
        }
        titleLabel.text = viewData.fullName

        switch viewData.stargazersCount {
        case 0...10:
            popularityLabel.isHidden = true
        case 11...50:
            popularityLabel.text = "⭐"
        case 51...150:
            popularityLabel.text = "⭐⭐"
        case 151...300:
            popularityLabel.text = "⭐⭐⭐"
        case 301...Int.max:
            popularityLabel.text = "⭐⭐⭐⭐"
        default:
            popularityLabel.isHidden = true
        }
    }
}
