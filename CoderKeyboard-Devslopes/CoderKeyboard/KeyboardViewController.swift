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
    //@IBOutlet var bracesHotButton: UIButton!
    
    //MARK ====> Vars
    var bracesHotButton: UIButton!
    var bracketsHotButton: UIButton!
    var varHotButton: UIButton!
    var letHotButton: UIButton!
    var quoteHotButton: UIButton!
    var codeHotButton: UIButton!
    var horizHotStackView: UIStackView!
    var arrayOfHotButtons: [UIButton] = []
    var backButton: UIButton!
    var actionLabel: UILabel!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let textColor: UIColor = UIColor.white
        let viewBgColor: UIColor = UIColor(red: 63/255, green: 64/255, blue: 68/255, alpha: 0.5)
        
        actionLabel = UILabel()
        actionLabel.text = "RECENT"
        actionLabel.textColor = textColor
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(actionLabel)
        actionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10.0).isActive = true
        actionLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10.0).isActive = true
        
        self.view.backgroundColor = viewBgColor
        
        //MARK Our buttons
        self.bracesHotButton = makeHotButton(title: "{ }", desc: "Insert left and right Braces place cursor in the middle")
        self.bracketsHotButton = makeHotButton(title: "[ ]", desc: "Insert left and right Brackets place cursor in the middle")
        self.varHotButton = makeHotButton(title: "var", desc: "Insert var keyword place cursor after the word var")
        self.letHotButton = makeHotButton(title: "let", desc: "Insert let keyword place cursor after the word let")
        self.quoteHotButton = makeHotButton(title: "\" \"", desc: "Insert left and right quotes place cursor in the middle")
        self.codeHotButton = makeHotButton(title: "code", desc: "Insert code keyword place cursor after the word code")
        
        //MARK ====> THE STACK VIEW
        horizHotStackView = UIStackView(arrangedSubviews: arrayOfHotButtons)
        horizHotStackView.axis = .horizontal
        horizHotStackView.distribution = .fillEqually
        horizHotStackView.alignment = .fill
        horizHotStackView.spacing = 10
        horizHotStackView.translatesAutoresizingMaskIntoConstraints = false
        horizHotStackView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        self.view.addSubview(horizHotStackView)
        
        //Setting Stack background color
        let colorView = UIView(frame: horizHotStackView.bounds)
        colorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        colorView.backgroundColor = viewBgColor
        colorView.layer.zPosition = 1
        
        //horizHotStackView.addSubview(colorView)
        //horizHotStackView.sendSubview(toBack: colorView)

        horizHotStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        horizHotStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10.0).isActive = true
        horizHotStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10.0).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here DEFAULT SECTION
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Back", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    
    //makeHotButton is meant to create a new UIButton for our HotButtons array then add them to the array
    func makeHotButton(title: String, desc: String) -> UIButton{
        let button = UIButton(type: .system)
        let buttonBgColor: UIColor = UIColor(red: 41/255, green: 43/255, blue: 53/255, alpha: 0.5)
        button.setTitle(NSLocalizedString(title, comment: desc), for: [])
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = arrayOfHotButtons.count
        button.addTarget(self, action: #selector(action), for: UIControlEvents.touchUpInside)
        button.layer.zPosition = 2
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        //button.layer.borderColor = UIColor.cyan.cgColor
        button.layer.backgroundColor = buttonBgColor.cgColor
        var textColor: UIColor = UIColor.white //default
        if title == "var" || title == "let" {
            textColor = UIColor(red: 240/255, green: 53/255, blue: 253/255, alpha: 1)
        } else if title == "\" \"" {
            textColor = UIColor(red: 255/255, green: 1/255, blue: 1/255, alpha: 1)
        }
        
        button.setTitleColor(textColor, for:[])
        //button.titleLabel?.font = UIFont(name: "Montserrat", size: 12)!
        arrayOfHotButtons += [button]
        return button
    }
    
    @objc func action(sender: UIButton) {
        
        if let buttonTitle = sender.title(for: .normal) {
            print("Button \(buttonTitle) was clicked with tag = \(sender.tag)")
            self.textDocumentProxy.insertText("\(buttonTitle)")
        }
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
        
    }

}
