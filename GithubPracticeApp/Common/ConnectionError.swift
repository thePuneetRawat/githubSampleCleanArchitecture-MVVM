//
//  ConnectionError.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation

public protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
