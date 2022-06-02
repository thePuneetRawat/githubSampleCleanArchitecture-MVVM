//
//  PrDataRequestObject.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 08/05/22.
//

import Foundation

struct PrDataRequestObject {
    let user: String
    let repo: String
    let queryParam: PRDataQuery
}

struct PRDataQuery: Encodable {
    let state: String
}
