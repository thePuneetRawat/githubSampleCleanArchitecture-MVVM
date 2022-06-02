//
//  ManagerTask.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 08/05/22.
//

import Foundation

class ManagerTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
