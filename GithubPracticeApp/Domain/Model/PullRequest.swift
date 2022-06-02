//
//  PullRequest.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation
import UIKit

struct PullRequest: Codable, Identifiable {
    typealias Identifier = Double
    
    var id: Identifier
    var title: String
    var created: String
    var closed: String?
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case created = "created_at"
        case closed = "closed_at"
        case user
    }
}

struct User: Codable, Identifiable {
    typealias Identifier = Double
    
    var id: Identifier
    var name: String
    var avatarImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarImage = "avatar_url"
    }
}


struct SearchPullRequestCaseRequestValue {
    let query: PullRequestQuery
    let page: Int
}
