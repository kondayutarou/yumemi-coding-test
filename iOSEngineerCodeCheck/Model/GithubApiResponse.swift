//
//  GithubApiResponse.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

// See: https://docs.github.com/en/rest/search?apiVersion=2022-11-28#search-repositories
// MARK: - GithubRepositoryListResponse
struct GithubRepositoryListResponse: Codable {
    let items: [GithubRepositoryListItemResponse]
}

// MARK: - GithubRepositoryListItemResponse
struct GithubRepositoryListItemResponse: Codable {
    let id: Int
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let fullName: String
    let owner: GithubRepositoryListItemOwnerResponse?

    enum CodingKeys: String, CodingKey {
        case id
        case language
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case fullName = "full_name"
        case owner
    }
}

extension GithubRepositoryListItemResponse: Equatable {
    static func == (lhs: GithubRepositoryListItemResponse, rhs: GithubRepositoryListItemResponse) -> Bool {
        lhs.id == rhs.id
    }
}

struct GithubRepositoryListItemOwnerResponse: Codable {
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
