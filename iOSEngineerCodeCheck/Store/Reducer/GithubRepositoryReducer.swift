//
//  GithubRepositoryReducer.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

func githubRepositoryReducer(_ state: GithubRepositoryState, action: GithubRepositoryAction) -> GithubRepositoryState {
    var state = state

    switch action {
    case let .didReceiveGithubRepositoryList(result: result):
        state.repositoryList = result
    default:
        break
    }

    return state
}
