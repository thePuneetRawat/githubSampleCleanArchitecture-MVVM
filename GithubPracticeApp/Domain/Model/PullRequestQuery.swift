//
//  File.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation

struct PullRequestQuery: Equatable {
    let repository: String
    let username: String
    let pullRequestType: PullRequestType
}

enum PullRequestType: String, CaseIterable{
    case open, closed, all
}
