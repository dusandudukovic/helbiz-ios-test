//
//  BaseViewController.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Global IBOutlets
    
    @IBOutlet weak var mainScrollView: UIScrollView?
    @IBOutlet weak var mainContentView: UIView?
    @IBOutlet weak var mainBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Private properties
    
    private var backgroundTapGestureRecognizer: UITapGestureRecognizer?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
        setupLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    // MARK: - Gesture Recognizer logic
    
    private func setupGestureRecognizer() {
        if let view = mainContentView {
            backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponder))
            backgroundTapGestureRecognizer!.delegate = self
            view.addGestureRecognizer(backgroundTapGestureRecognizer!)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    override func resignFirstResponder() -> Bool {
        if let tf = mainContentView?.selectedTextField {
            return tf.resignFirstResponder()
        }
        if let tv = mainContentView?.selectedTextView {
            return tv.resignFirstResponder()
        }
        return super.resignFirstResponder()
    }
    
    // MARK: - Keyboard notifications
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Keyboard functions
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let size = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            if let rate = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
                
                let safeAreaBottom: CGFloat
                if #available(iOS 11.0, *) {
                  safeAreaBottom = self.view.safeAreaInsets.bottom
                } else {
                  safeAreaBottom = 0.0
                }
                
                mainBottomConstraint?.constant = size.height - safeAreaBottom
                
                UIView.animate(withDuration: Double(truncating: rate), animations: {
                    self.view.layoutIfNeeded()
                }) { bool in }
            }
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        if let rate = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            mainBottomConstraint?.constant = 0
            
            UIView.animate(withDuration: Double(truncating: rate), animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc
    internal func setupLocalization() {
        // override in subclasses
    }
}

