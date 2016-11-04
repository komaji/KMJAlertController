//
//  KMJAlertController.swift
//  KMJAlertController
//
//  Created by KojimaTatsuya on 2016/11/01.
//  Copyright © 2016年 komaji. All rights reserved.
//

import UIKit

public enum KMJAlertButtonStyle: Int {
    case Cancel, Destructive, Default
}

public class KMJAlertController {
    
    public static func showAlert(viewController: UIViewController,
                                 title: String?,
                                 message: String?,
                                 cancelButtonTitle cancelActionTitle: String?,
                                 destructiveButtonTitle destructiveActionTitle: String?,
                                 defaultButtonTitles defaultActionTitles: [String]?,
                                 handler: ((_ alert: UIAlertController, _ action: UIAlertAction, _ button: KMJAlertButton) -> Void)? = nil) {
        show(viewController: viewController,
             title: title,
             message: message,
             preferredStyle: .alert,
             cancelActionTitle: cancelActionTitle,
             destructiveActionTitle: destructiveActionTitle,
             defaultActionTitles: defaultActionTitles,
             popoverPresentationControllerHandler: nil,
             handler: handler)
    }
    
    public static func showActionSheet(viewController: UIViewController,
                                       title: String?,
                                       message: String?,
                                       cancelButtonTitle cancelActionTitle: String?,
                                       destructiveButtonTitle destructiveActionTitle: String?,
                                       defaultButtonTitles defaultActionTitles: [String]?,
                                       popoverPresentationControllerHandler: ((UIPopoverPresentationController) -> Void)?,
                                       handler: ((_ alert: UIAlertController, _ action: UIAlertAction, _ button: KMJAlertButton) -> Void)? = nil) {
        show(viewController: viewController,
             title: title,
             message: message,
             preferredStyle: .actionSheet,
             cancelActionTitle: cancelActionTitle,
             destructiveActionTitle: destructiveActionTitle,
             defaultActionTitles: defaultActionTitles,
             popoverPresentationControllerHandler: popoverPresentationControllerHandler,
             handler: handler)
    }
    
}

private extension KMJAlertController {
    
    static func show(viewController: UIViewController,
                     title: String?,
                     message: String?,
                     preferredStyle: UIAlertControllerStyle,
                     cancelActionTitle: String?,
                     destructiveActionTitle: String?,
                     defaultActionTitles: [String]?,
                     popoverPresentationControllerHandler: ((UIPopoverPresentationController) -> Void)?,
                     handler: ((_ alert: UIAlertController, _ action: UIAlertAction, _ button: KMJAlertButton) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if let cancelActionTitle = cancelActionTitle {
            let cancelAction = UIAlertAction(title: cancelActionTitle,
                                             style: .cancel,
                                             handler: { action in
                                                handler?(alert, action, KMJAlertButton(index: KMJAlertButtonStyle.Cancel.rawValue))
            })
            
            alert.addAction(cancelAction)
        }
        
        if let destructiveActionTitle = destructiveActionTitle {
            let destructiveAction = UIAlertAction(title: destructiveActionTitle,
                                                  style: .destructive,
                                                  handler: { action in
                                                    handler?(alert, action, KMJAlertButton(index: KMJAlertButtonStyle.Destructive.rawValue))
            })
            
            alert.addAction(destructiveAction)
        }
        
        if let defaultActionTitles = defaultActionTitles {
            let defaultActions = defaultActionTitles.enumerated().map{ index, title in
                UIAlertAction(title: title,
                              style: .default,
                              handler: { action in
                                handler?(alert, action, KMJAlertButton(index: KMJAlertButtonStyle.Default.rawValue + index))
                })
            }
            
            defaultActions.forEach { alert.addAction($0) }
        }
        
        if let popover = alert.popoverPresentationController {
            popoverPresentationControllerHandler?(popover)
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }

}

public struct KMJAlertButton {
    
    public let index: Int
    
    public var style: KMJAlertButtonStyle {
        switch index {
        case KMJAlertButtonStyle.Cancel.rawValue:
            return .Cancel
        case KMJAlertButtonStyle.Destructive.rawValue:
            return .Destructive
        default:
            return .Default
        }
    }
    
    public var indexInDefault: Int? {
        if style == .Default {
            return index - style.rawValue
        }
        
        return nil
    }
    
    init(index: Int) {
        self.index = index
    }
    
}
