//
//  MainViewController+Combine.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Combine
import Toast
import SwiftUI

extension MainViewController {
    func subscribeToStore() {
        let shared = store.$state.map { $0.githubRepositoryState }
            .receive(on: DispatchQueue.main)

        shared
            .map { $0.repositoryList }
            .filter { !$0.isEmpty }
            .sink { [weak self] repositoryList in
                guard let self else { return }
                self.githubRepositoryList = repositoryList
                self.tableView.reloadData()
            }
            .store(in: &cancellableSet)

        shared
            .dropFirst()
            .compactMap { $0.repositoryListError }
            .sink { [weak self] error in
                guard let self else { return }

                let viewController = ErrorViewWrapper(rootView: ErrorView(errorDescription: error.localizedDescription))
                viewController.modalPresentationStyle = .overCurrentContext
                self.present(viewController, animated: false)
            }
            .store(in: &cancellableSet)
    }
}
