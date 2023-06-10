//
//  Store.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middleware<StoreState: ReduxState> = (StoreState, Action, Store<StoreState>) -> Void

protocol ReduxState {}

struct AppState: ReduxState {
    var githubRepositoryState = GithubRepositoryState()
}

struct GithubRepositoryState: ReduxState {
    var repositoryList: [GithubRepositoryListItemResponse] = []
}

struct Services {
    let githubRepositoryService: GithubRepositoryService
}

final class Store<StoreState: ReduxState>: ObservableObject {
    private(set) var reducer: Reducer<StoreState>
    @Published var state: StoreState
    private(set) var middlewares: [Middleware<StoreState>]
    private(set) var services: Services
    
    init(
        reducer: @escaping Reducer<StoreState>,
        state: StoreState,
        middlewares: [Middleware<StoreState>]
    ) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
        self.services = Services(
            githubRepositoryService: GithubRepositoryServiceImpl()
        )
    }
    
    func dispatch(_ action: Action) {
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
        
        middlewares.forEach { middleware in
            middleware(state, action, self)
        }
    }
}
