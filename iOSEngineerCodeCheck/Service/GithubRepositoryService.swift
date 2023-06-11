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
    func fetchAvatarImage(avatarURL: String, dispatcher: Store<AppState>) async
}

final class GithubRepositoryServiceImpl: GithubRepositoryService {
    func fetchGithubRepositoryList(with query: String, dispatcher: Store<AppState>) async {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") else {
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            let decoded = try JSONDecoder().decode(GithubRepositoryListResponse.self, from: data)
            dispatcher.dispatch(.githubRepository(.didReceiveGithubRepositoryList(result: decoded.items)))
        } catch {
            dispatcher.dispatch(.githubRepository(.githubRepositoryListError(error)))
        }
    }

    func fetchAvatarImage(avatarURL: String, dispatcher: Store<AppState>) async {
        guard let avatarURL = URL(string: avatarURL) else { return }
        do {
            let (data, response) = try await URLSession.shared.data(from: avatarURL)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            dispatcher.dispatch(.githubRepository(.didReceiveAvatarImage(data: data)))
        } catch {
        }
    }
}
