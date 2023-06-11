//
//  GithubRepositoryReducerTest.swift
//  iOSEngineerCodeCheckTests
//
//  Created by Yutaro on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import iOSEngineerCodeCheck

final class GithubRepositoryReducerTest: QuickSpec {
    override class func spec() {
        let mockState = GithubRepositoryState()
        describe("Reduce GithubAction") {
            it("When repository list is fetched, only repositoryList should be updated") {
                let decodedResponse = GithubRepositoryListItemResponse(
                    id: 300000,
                    language: nil,
                    stargazersCount: 70,
                    watchersCount: 80,
                    forksCount: 90,
                    openIssuesCount: 100,
                    fullName: "YUMEMI",
                    owner: nil
                )

                let reducedState = githubRepositoryReducer(mockState, action: .didReceiveGithubRepositoryList(result: [
                    decodedResponse
                ]))

                expect(reducedState.repositoryList).to(equal([decodedResponse]))
                expect(reducedState.avatarData).to(beNil())
            }
        }
    }
}
