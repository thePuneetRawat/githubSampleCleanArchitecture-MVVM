//
//  EndPoints.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 08/05/22.
//

import Foundation

struct APIEndpoints {
    
    static func getPRs(with prRequestQuery: PrDataRequestObject) -> Endpoint<[PullRequest]> {

        let user = prRequestQuery.user
        let repoName = prRequestQuery.repo
        
        return Endpoint(path: "\(user)/\(repoName)/pulls",
                        method: .get,
                        queryParametersEncodable: prRequestQuery.queryParam)
    }

    static func getAvatarImage(path: String) -> Endpoint<Data> {
        return Endpoint(path: "\(path)",
                        isFullPath: true,
                        method: .get,
                        responseDecoder: RawDataResponseDecoder())
    }
}
