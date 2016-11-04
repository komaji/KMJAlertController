//
//  ViewController.swift
//  KMJAlertControllerDemo
//
//  Created by KojimaTatsuya on 2016/11/01.
//  Copyright © 2016年 komaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func alertButtonDidTap(_ sender: UIButton) {
        KMJAlertController.showAlert(viewController: self,
                                     title: "Alert Title",
                                     message: "Alert Message",
                                     cancelButtonTitle: "Cancel",
                                     destructiveButtonTitle: "Destructive",
                                     defaultButtonTitles: ["Default0", "Default1"]) { alert, action, button in
                                        switch button.style {
                                        case .Cancel:
                                            print("Cancel")
                                        case .Destructive:
                                            print("Destructive")
                                        case .Default:
                                            print("Default\(button.indexInDefault!)")
                                        }
        }
    }
    
    @IBAction func actionSheetDidTap(_ sender: UIButton) {
        KMJAlertController.showActionSheet(viewController: self,
                                           title: "Action Sheet Title",
                                           message: "Action Sheet Message",
                                           cancelButtonTitle: "Cancel",
                                           destructiveButtonTitle: "Destructive",
                                           defaultButtonTitles: ["Default0", "Default1"],
                                           popoverPresentationControllerHandler: { popover in
                                            popover.sourceView = self.view
                                            popover.sourceRect = sender.frame
        },
                                           handler: { alert, action, button in
                                            switch button.style {
                                            case .Cancel:
                                                print("Cancel")
                                            case .Destructive:
                                                print("Destructive")
                                            case .Default:
                                                print("Default\(button.indexInDefault!)")
                                            }
        })
    }
    
}

