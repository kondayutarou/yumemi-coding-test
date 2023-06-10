//
//  MainViewController+Combine.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Combine

extension MainViewController {
    func subscribeToStore() {
        store.$state.map { $0.githubRepositoryState.repositoryList }
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] repositoryList in
                guard let self else { return }
                self.githubRepositoryList = repositoryList
                self.tableView.reloadData()
            }
            .store(in: &cancellableSet)
    }
}
