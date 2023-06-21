//
//  TagmateSDK.swift
//  TagmatePOC
//
//  Created by Navin Rai on 21/06/23.
//

import Foundation
import UIKit
import Firebase
import FirebaseAnalytics

public class TagmatePOC {
    
    public static func initializeFirebase() {
        // Check if FirebaseApp is already configured
        if FirebaseApp.app() == nil {
            // Configure Firebase
            FirebaseApp.configure()
        }
    }
    
    public static func logEvent(eventName: String, parameters: [String: Any]?) {
        // Log an event to FirebaseAnalytics
        Analytics.logEvent(eventName, parameters: parameters)
    }
    
    public static func createTextFieldButtonView() -> UIView {
        let containerView = UIView()
        
        let textField = UITextField()
        textField.placeholder = "Enter text"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(textField)
        
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        button.addTarget(self, action: #selector(saveText(_:)), for: .touchUpInside)
        
        return containerView
    }
    
    @objc private static func saveText(_ sender: UIButton) {
        guard let containerView = sender.superview else {
            return
        }
        
        let textField = containerView.subviews.first(where: { $0 is UITextField }) as? UITextField
        if let text = textField?.text {
            print("Saved text: \(text)")
            // You can perform any necessary operations with the saved text here
            TagmatePOC.logEvent(eventName: "Text_Saved", parameters: ["Saved_Text": text])
        }
    }
    
    // Other SDK functionalities...
    
}
