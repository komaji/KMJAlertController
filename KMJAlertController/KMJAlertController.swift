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
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let cancelActionTitle = cancelActionTitle {
            alert.addAction(
                UIAlertAction(title: cancelActionTitle,
                              style: .cancel,
                              handler: { action in
                                handler?(alert, action, KMJAlertButton(index: KMJAlertButtonStyle.Cancel.rawValue))
                })
            )
            
        }
        
        if let destructiveActionTitle = destructiveActionTitle {
            alert.addAction(
                UIAlertAction(title: destructiveActionTitle,
                              style: .destructive,
                              handler: { action in
                                handler?(alert, action, KMJAlertButton(index: KMJAlertButtonStyle.Destructive.rawValue))
                })
            )
        }
        
        if let defaultActionTitles = defaultActionTitles {
            defaultActionTitles.enumerated().map{ index, title in
                UIAlertAction(title: title,
                              style: .default,
                              handler: { action in
                                handler?(alert, action, KMJAlertButton(index: KMJAlertButtonStyle.Default.rawValue + index))
                })
            }.forEach {
                alert.addAction($0)
            }
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
