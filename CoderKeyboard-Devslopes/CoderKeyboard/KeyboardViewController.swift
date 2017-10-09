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
    var horizKeyRow1: UIStackView!
    var horizKeyRow2: UIStackView!
    var horizKeyRow3: UIStackView!
    var horizKeyRow4: UIStackView!
    var vertKeyboardStackView: UIStackView!
    var arrayOfHotButtons: [UIButton] = []
    var arrayOfKeysRow1: [UIButton] = []
    var arrayOfKeysRow2: [UIButton] = []
    var arrayOfKeysRow3: [UIButton] = []
    var arrayOfKeysRow4: [UIButton] = []
    var arrayOfKeyboardRows: [UIStackView] = []
    var backButton: UIButton!
    var actionLabel: UILabel!
    var buttonsTextColor: UIColor = UIColor.white //default
    var insertBetween: Bool = false //default
    
    
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
        self.bracesHotButton = makeHotButton(title: "{}", desc: "Insert left and right Braces place cursor in the middle")
        self.bracketsHotButton = makeHotButton(title: "[]", desc: "Insert left and right Brackets place cursor in the middle")
        self.varHotButton = makeHotButton(title: "var", desc: "Insert var keyword place cursor after the word var")
        self.letHotButton = makeHotButton(title: "let", desc: "Insert let keyword place cursor after the word let")
        self.quoteHotButton = makeHotButton(title: "\"\"", desc: "Insert left and right quotes place cursor in the middle")
        self.codeHotButton = makeHotButton(title: "code", desc: "Insert code keyword place cursor after the word code")
        
        //MARK ====> THE STACK VIEW
        horizHotStackView = UIStackView(arrangedSubviews: arrayOfHotButtons)
        horizHotStackView.axis = .horizontal
        horizHotStackView.distribution = .fillEqually
        horizHotStackView.alignment = .fill
        horizHotStackView.spacing = 10
        horizHotStackView.translatesAutoresizingMaskIntoConstraints = false
        horizHotStackView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        //self.view.addSubview(horizHotStackView)
        arrayOfKeyboardRows += [horizHotStackView]
        //Setting Stack background color
        let colorView = UIView(frame: horizHotStackView.bounds)
        colorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        colorView.backgroundColor = viewBgColor
        colorView.layer.zPosition = 1
        
        //horizHotStackView.addSubview(colorView)
        //horizHotStackView.sendSubview(toBack: colorView)

        ///horizHotStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        ///horizHotStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10.0).isActive = true
        ///horizHotStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10.0).isActive = true
        
        //MARK =====> Making the keyboard ROW 1
        buildRegularKeyboard()
        horizKeyRow1.axis = .horizontal
        horizKeyRow1.distribution = .fillEqually
        horizKeyRow1.alignment = .fill
        horizKeyRow1.spacing = 10
        horizKeyRow1.translatesAutoresizingMaskIntoConstraints = false
        horizKeyRow1.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        arrayOfKeyboardRows += [horizKeyRow1]
        
        horizKeyRow2.axis = .horizontal
        horizKeyRow2.distribution = .fillEqually
        horizKeyRow2.alignment = .fill
        horizKeyRow2.spacing = 10
        horizKeyRow2.translatesAutoresizingMaskIntoConstraints = false
        horizKeyRow2.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        arrayOfKeyboardRows += [horizKeyRow2]

        
        //MARK ====> ADD The Vertical Stack to the View and Constrain it to the sides
        vertKeyboardStackView = UIStackView(arrangedSubviews: arrayOfKeyboardRows)
        vertKeyboardStackView.axis = .vertical
        vertKeyboardStackView.distribution = .fillEqually
        vertKeyboardStackView.spacing = 10
        vertKeyboardStackView.translatesAutoresizingMaskIntoConstraints = false
        vertKeyboardStackView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]

        self.view.addSubview(vertKeyboardStackView)
        vertKeyboardStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        vertKeyboardStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10.0).isActive = true
        vertKeyboardStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10.0).isActive = true
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
        button.layer.backgroundColor = buttonBgColor.cgColor
        switch title {
        case "var","let":
            buttonsTextColor = UIColor(red: 240/255, green: 53/255, blue: 253/255, alpha: 1)
        case "\"\"":
            buttonsTextColor = UIColor(red: 255/255, green: 1/255, blue: 1/255, alpha: 1)
        case "{}","[]":
            buttonsTextColor = UIColor.white
        default:
            buttonsTextColor = UIColor.white
        }
        
        button.setTitleColor(buttonsTextColor, for:[])
        //button.titleLabel?.font = UIFont(name: "Montserrat", size: 12)!
        arrayOfHotButtons += [button]
        return button
    }
    
    @objc func action(sender: UIButton) {
        
        if let buttonTitle = sender.title(for: .normal) {
            switch buttonTitle {
            case "var","let":
                buttonsTextColor = UIColor(red: 240/255, green: 53/255, blue: 253/255, alpha: 1)
                insertBetween = false
            case "\"\"":
                buttonsTextColor = UIColor(red: 255/255, green: 1/255, blue: 1/255, alpha: 1)
                insertBetween = true
            case "{}","[]":
                buttonsTextColor = UIColor.white
                insertBetween = true
            default:
                buttonsTextColor = UIColor.white
                insertBetween = false
            }
            
            print("Button \(buttonTitle) was clicked with tag = \(sender.tag)")
            if buttonTitle == "code" {
                self.textDocumentProxy.insertText("<\(buttonTitle)>")
                self.textDocumentProxy.insertText("</\(buttonTitle)>")
                self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -7)
            } else {
                self.textDocumentProxy.insertText("\(buttonTitle)")
            }

            if insertBetween {
                self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
            }
        }
    }
    
    func buildRegularKeyboard() {
        //MARK ====> ROW 1 of Keyboard
        let keyQ = addRegularKey(title: "q", desc: "q")
        arrayOfKeysRow1 += [keyQ]
        let keyW = addRegularKey(title: "w", desc: "w")
        arrayOfKeysRow1 += [keyW]
        let keyE = addRegularKey(title: "e", desc: "e")
        arrayOfKeysRow1 += [keyE]
        let keyR = addRegularKey(title: "r", desc: "r")
        arrayOfKeysRow1 += [keyR]
        let keyT = addRegularKey(title: "t", desc: "t")
        arrayOfKeysRow1 += [keyT]
        let keyY = addRegularKey(title: "y", desc: "y")
        arrayOfKeysRow1 += [keyY]
        let keyU = addRegularKey(title: "u", desc: "u")
        arrayOfKeysRow1 += [keyU]
        let keyI = addRegularKey(title: "i", desc: "i")
        arrayOfKeysRow1 += [keyI]
        let keyO = addRegularKey(title: "o", desc: "o")
        arrayOfKeysRow1 += [keyO]
        let keyP = addRegularKey(title: "p", desc: "p")
        arrayOfKeysRow1 += [keyP]
        horizKeyRow1 = UIStackView(arrangedSubviews: arrayOfKeysRow1)
        
        //MARK ====> ROW 1 of Keyboard
        let keyA = addRegularKey(title: "a", desc: "a")
        arrayOfKeysRow2 += [keyA]
        let keyS = addRegularKey(title: "s", desc: "s")
        arrayOfKeysRow2 += [keyS]
        let keyD = addRegularKey(title: "d", desc: "d")
        arrayOfKeysRow2 += [keyD]
        let keyF = addRegularKey(title: "f", desc: "f")
        arrayOfKeysRow2 += [keyF]
        let keyG = addRegularKey(title: "g", desc: "g")
        arrayOfKeysRow2 += [keyG]
        let keyH = addRegularKey(title: "h", desc: "h")
        arrayOfKeysRow2 += [keyH]
        let keyJ = addRegularKey(title: "j", desc: "j")
        arrayOfKeysRow2 += [keyJ]
        let keyK = addRegularKey(title: "k", desc: "k")
        arrayOfKeysRow2 += [keyK]
        let keyL = addRegularKey(title: "l", desc: "l")
        arrayOfKeysRow2 += [keyL]
        horizKeyRow2 = UIStackView(arrangedSubviews: arrayOfKeysRow2)

    }
    
    func addRegularKey(title: String, desc: String) -> UIButton{
        let button = UIButton(type: .system)
        let buttonBgColor: UIColor = UIColor.gray
        button.setTitle(NSLocalizedString(title, comment: desc), for: [])
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.tag = arrayOfHotButtons.count
        button.addTarget(self, action: #selector(action), for: UIControlEvents.touchUpInside)
        button.layer.zPosition = 2
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.backgroundColor = buttonBgColor.cgColor
        
        button.setTitleColor(buttonsTextColor, for:[])
        //button.titleLabel?.font = UIFont(name: "Montserrat", size: 12)!
        //arrayOfHotButtons += [button]
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
        
    }

}
