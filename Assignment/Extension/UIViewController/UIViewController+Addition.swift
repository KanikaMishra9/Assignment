//
//  UIViewController+Addition.swift
//  Assignment
//
//  Created by Kanika on 10/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    struct ActivityIndicator {
        static var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Constant.alertTitle, style: .default) { (_) in
        }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoader() {
        ActivityIndicator.activityIndicator.color = UIColor.gray
        if !view.subviews.contains(ActivityIndicator.activityIndicator) {
            view.addSubview(ActivityIndicator.activityIndicator)
            ActivityIndicator.activityIndicator.center = view.center
        }
        ActivityIndicator.activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        ActivityIndicator.activityIndicator.stopAnimating()
        ActivityIndicator.activityIndicator.removeFromSuperview()
    }
    
}
