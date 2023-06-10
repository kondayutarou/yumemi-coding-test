//
//  GithubRepositoryAction.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

enum GithubRepositoryAction {
    case fetchGithubRepositoryList(query: String)
    case didReceiveGithubRepositoryList(result: [GithubRepositoryListItemResponse])
    case didReceiveError
    case fetchAvatarImage(index: Int)
    case didReceiveAvatarImage(data: Data)
}
