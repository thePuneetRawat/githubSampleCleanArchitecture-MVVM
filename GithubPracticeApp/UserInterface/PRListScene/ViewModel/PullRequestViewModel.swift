//
//  PRViewModel.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation
struct PullRequestViewModel: Equatable {
    let title: String?
    let createdAt: String?
    let closedAt: String?
    let username: String?
    let userImg: String?
}

struct DateFormat {
    static let apiDateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    static let outputDateFormat = "MMM dd,yyyy"
}

extension PullRequestViewModel {

    init(pr: PullRequest) {
        self.title = pr.title
        self.username = pr.user.name
        self.createdAt = DateUtil.shared.convertDateString(from: DateFormat.apiDateFormat, to: DateFormat.outputDateFormat, dateStr: pr.created)
        self.closedAt = DateUtil.shared.convertDateString(from: DateFormat.apiDateFormat, to: DateFormat.outputDateFormat, dateStr: pr.closed ?? "")
        self.userImg = pr.user.avatarImage
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
