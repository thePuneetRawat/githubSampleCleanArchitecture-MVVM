//
//  AppAppearance.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation
import UIKit

final class AppAppearance {
    static func setupAppearance() {
        // do initial app setup here
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
