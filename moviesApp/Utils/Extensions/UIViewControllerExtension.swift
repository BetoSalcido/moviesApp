//
//  UIViewControllerExtension.swift
//  moviesApp
//
//  Created by Beto Salcido on 01/02/21.
//

import Foundation
import UIKit

@objc
extension UIViewController {
    
    /// Method to add a loadingView in the mainView
    @objc func showLoadingView(transparent: Bool = true) {
        DispatchQueue.main.async {
            let container = UIView()
            let activityIndicator = UIActivityIndicatorView()
            
            container.frame = self.view.frame
            container.center = self.view.center
            container.backgroundColor = transparent ? UIColor.clear :UIColor.black.withAlphaComponent(0.5)
            container.tag = 10000
            
            activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0);
            if #available(iOS 13.0, *) {
                activityIndicator.style = UIActivityIndicatorView.Style.large
            } else {
                activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
                activityIndicator.style = .gray
            }
            activityIndicator.center = self.view.center
            activityIndicator.tag = 11000
            
            container.addSubview(activityIndicator)
            self.view.addSubview(container)
            activityIndicator.startAnimating()
        }
    }
    
    /// Method to remove a loadingView in the mainView
    @objc func removeLoadingView() {
        DispatchQueue.main.async {
            for view in self.view.subviews {
                if (view.tag == 10000) {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    @objc func showSimpleAlertController(title: String?, message: String?, actionTitle: String, actionBlock: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionTitle, style: .default, handler: actionBlock)
        alertController.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

