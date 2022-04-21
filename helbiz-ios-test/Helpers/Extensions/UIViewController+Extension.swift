//
//  UIViewController+Extension.swift
//

import UIKit

extension UIViewController {
    func showAlert(title: String,
                   message: String,
                   buttonTitle: String,
                   showCancel: Bool = false,
                   buttonHandler: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: buttonHandler))
        if showCancel {
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertWithTextField(title: String,
                                message: String,
                                text: String?,
                                saveHandler: ((String?) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField!) in
            textField.text = text
            textField.placeholder = "Description..."
            textField.autocapitalizationType = .sentences
            textField.enablesReturnKeyAutomatically = true
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (alert) in
            if let tf = alertController.textFields?.first {
                saveHandler?(tf.text)
            }
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showActionSheet(title: String?, message: String?, actions: [(title: String, handler: ((UIAlertAction) -> Void)?)]) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for a in actions {
            let action = UIAlertAction(title: a.title, style: .default, handler: a.handler)
            action.setValue(UIColor.actionColor, forKey: "titleTextColor")
            controller.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        cancel.setValue(UIColor.actionColor, forKey: "titleTextColor")
        controller.addAction(cancel)
        
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func showSecondaryActionSheet(title: String?, message: String?, actions: [(title: String, handler: ((UIAlertAction) -> Void)?)]) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for a in actions {
            let action = UIAlertAction(title: a.title, style: .default, handler: a.handler)
            action.setValue(UIColor.actionColor, forKey: "titleTextColor")
            controller.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        cancel.setValue(UIColor.actionColor, forKey: "titleTextColor")
        controller.addAction(cancel)
        
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: nil)
        }
    }
    
}
