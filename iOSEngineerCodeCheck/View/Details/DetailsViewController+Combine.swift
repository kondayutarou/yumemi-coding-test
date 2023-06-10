//
//  DetailsViewController+Combine.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
import Combine

extension DetailsViewController {
    func subscribeToStore() {
        store.$state.compactMap { $0.githubRepositoryState.avatarData }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self else { return }
                self.avatarImageView.image = UIImage(data: data)
            }
            .store(in: &cancellableSet)
    }
}
