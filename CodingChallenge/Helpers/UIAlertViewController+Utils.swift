//
//  UIAlertViewController+Utils.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func createSimpleAlertControllerWithMessage(_ message: String,title: String, viewController: UIViewController){
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        //Autolayout
        alertController.view.setNeedsLayout()
        viewController.present(alertController, animated: true, completion: nil)
        
    }
}
