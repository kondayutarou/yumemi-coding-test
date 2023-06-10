//
//  AppReducer.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action) -> AppState {
    var state = state

    switch action {
    case .githubRepository(let action):
        state.githubRepositoryState = githubRepositoryReducer(state.githubRepositoryState, action: action)
    }

    return state
}
