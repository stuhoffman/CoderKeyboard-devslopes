//
//  KeyboardViewController.swift
//  CoderKeyboard
//
//  Created by Stuart Hoffman on 10/5/17.
//  Copyright © 2017 Stuart Hoffman. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
//MARK =====> OUTLETS
    @IBOutlet var nextKeyboardButton: UIButton!
    
    
    //MARK ====> Vars
    var bracesHotButton: UIButton!
    var bracketsHotButton: UIButton!
    var varHotButton: UIButton!
    var letHotButton: UIButton!
    var quoteHotButton: UIButton!
    var codeHotButton: UIButton!
    var horizHotStackView: UIStackView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horizHotStackView = UIStackView()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        //MARK Our buttons
        self.bracesHotButton = UIButton(type: .system)
        self.bracesHotButton.setTitle(NSLocalizedString("{ }", comment: "Insert Left and Right Braces place cursor in the middle"), for: [])
        self.bracesHotButton.sizeToFit()
        self.bracesHotButton.translatesAutoresizingMaskIntoConstraints = false
        self.bracesHotButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        self.view.addSubview(self.bracesHotButton)
        self.bracesHotButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.bracesHotButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

        self.bracketsHotButton = makeHotButton(title: "[ ]", desc: "Insert Left and Right Brackets place cursor in the middle")
        

    }
    
    func makeHotButton(title: String, desc: String) -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString(title, comment: desc), for: [])
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        self.view.addSubview(button)
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        return button
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
        self.bracesHotButton.setTitleColor(textColor, for:[])
        self.bracketsHotButton.setTitleColor(textColor, for:[])
    }

}
