//
//  AppConfigurations.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation

final class AppConfiguration {
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
