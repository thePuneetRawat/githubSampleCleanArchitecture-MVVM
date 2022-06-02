//
//  HIdeNavigationBarBehavior.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 08/05/22.
//

import UIKit

struct HideNavigationBarBehavior: ViewControllerLifecycleBehavior {
    func viewWillAppear(viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func viewWillDisappear(viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
