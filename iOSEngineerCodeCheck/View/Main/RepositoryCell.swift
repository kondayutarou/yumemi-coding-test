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
    static let cellIdentifier = "RepositoryCell"
}
