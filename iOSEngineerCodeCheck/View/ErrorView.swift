//
//  ErrorView.swift
//  iOSEngineerCodeCheck
//
//  Created by Yutaro on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let errorDescription: String

    var body: some View {
        Text(errorDescription)
            .foregroundColor(Color("text"))
            .padding(16.0)
            .background(Color("primary"))
            .cornerRadius(16.0)
    }
}

struct ErrorViewPreview: PreviewProvider {
    static var previews: some View {
        ErrorView(errorDescription: "Internet unavailable")
    }
}

final class ErrorViewWrapper: UIHostingController<ErrorView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = true
        view.backgroundColor = .clear
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: false)
        }
    }
}
