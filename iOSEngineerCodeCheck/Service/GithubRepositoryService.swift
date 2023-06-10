//
//  GithubRepositoryService.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GithubRepositoryService {
    func fetchGithubRepositoryList(with query: String, dispatcher: Store<AppState>) async
}

final class GithubRepositoryServiceImpl: GithubRepositoryService {
    func fetchGithubRepositoryList(with query: String, dispatcher: Store<AppState>) async {}
}
