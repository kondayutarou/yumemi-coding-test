//
//  GithubRepositoryMiddleware.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

func githubRepositoryMiddleware() -> Middleware<AppState> {
    return { state, action, dispatcher in
        guard case let .githubRepository(action) = action else {
            return
        }
        
        switch action {
        case let .fetchGithubRepositoryList(query: query):
            Task {
                await dispatcher.services.githubRepositoryService.fetchGithubRepositoryList(
                    with: query, dispatcher: dispatcher
                )
            }
        default:
            break
        }
    }
}
