//
//  KeyboardViewController.swift
//  CoderKeyboard
//
//  Created by Stuart Hoffman on 10/5/17.
//  Copyright © 2017 Stuart Hoffman. All rights reserved.
//

import UIKit
import AudioToolbox

class KeyboardViewController: UIInputViewController {
//MARK: =====> OUTLETS
    @IBOutlet var nextKeyboardButton: UIButton!
    
    //MARK: ====> Vars
    var bracesHotButton: UIButton!
    var bracketsHotButton: UIButton!
    var varHotButton: UIButton!
    var letHotButton: UIButton!
    var quoteHotButton: UIButton!
    var codeHotButton: UIButton!
    var parenHotButton: UIButton!
    var anglesHotButton: UIButton!
    var lessthanHotButton: UIButton!
    var greaterthanHotButton: UIButton!
    var goesToHotButton: UIButton!
    var plusHotButton: UIButton!
    var minusHotButton: UIButton!
    var multiplyHotButton: UIButton!
    var divideHotButton: UIButton!
    var uibuttonHotButton: UIButton!
    var uilabelHotButton: UIButton!
    var iboutletHotButton: UIButton!
    var ibactionHotButton: UIButton!
    var horizSwipeStackView: UIStackView!
    var horizLabelStackView: UIStackView!
    var horizHotStackView: UIStackView!
    var horizOperatorStackView: UIStackView!
    var horizKeyRow1: UIStackView!
    var horizKeyRow2: UIStackView!
    var horizKeyRow3: UIStackView!
    var horizKeyRow4: UIStackView!
    var vertKeyboardStackView: UIStackView!
    var hotButtonScrollView: UIScrollView!
    var hotOperatorScrollView: UIScrollView!
    var arrayOfHotButtons: [UIButton] = []
    var arrayOfHotOperatorButtons: [UIButton] = []
    var arrayOfKeysRow1: [UIButton] = []
    var arrayOfKeysRow2: [UIButton] = []
    var arrayOfKeysRow3: [UIButton] = []
    var arrayOfKeysRow4: [UIButton] = []
    var arrayOfKeyboardRows: [UIView] = []
    var backButton: UIButton!
    var actionLabel: UILabel!
    var buttonsTextColor: UIColor = UIColor.white //default
    var insertBetween: Bool = false //default
    var addASpace: Bool = false //default
    var shiftIsOn: Bool = false //default
    var wrapSpaces: Bool = false //default
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let viewBgColor: UIColor = UIColor(red: 63/255, green: 64/255, blue: 68/255, alpha: 1)
        
        let recentButton: UIButton = UIButton()
        recentButton.setTitle(NSLocalizedString("SWIPE RIGHT FOR MORE", comment: "Recently Used Buttons"), for: [])
        recentButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 8)!
        recentButton.translatesAutoresizingMaskIntoConstraints = false
        horizLabelStackView = UIStackView(arrangedSubviews: [recentButton])
        horizLabelStackView.axis = .horizontal
        horizLabelStackView.distribution = .fill
        horizLabelStackView.alignment = .center
        horizLabelStackView.spacing = 4
        horizLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        horizLabelStackView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        self.view.addSubview(horizLabelStackView)
        horizLabelStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 1.0).isActive = true
        horizLabelStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        
        self.view.backgroundColor = viewBgColor
        
        //MARK: ====> HOT Buttons TOP ROW
        self.bracesHotButton = makeHotButton(title: "{}", desc: "Insert left and right Braces place cursor in the middle", row: "top")
        self.bracketsHotButton = makeHotButton(title: "[]", desc: "Insert left and right Brackets place cursor in the middle", row: "top")
        self.varHotButton = makeHotButton(title: "var", desc: "Insert var keyword place cursor after the word var", row: "top")
        self.letHotButton = makeHotButton(title: "let", desc: "Insert let keyword place cursor after the word let", row: "top")
        self.quoteHotButton = makeHotButton(title: "\"\"", desc: "Insert left and right quotes place cursor in the middle", row: "top")
        self.codeHotButton = makeHotButton(title: "code", desc: "Insert code keyword place cursor after the word code", row: "top")
        self.codeHotButton = makeHotButton(title: "func", desc: "Insert the keyword func", row: "top")
        self.codeHotButton = makeHotButton(title: "enum", desc: "Insert the keyword enum", row: "top")
        self.codeHotButton = makeHotButton(title: "return", desc: "Insert the keyword return", row: "top")
        self.codeHotButton = makeHotButton(title: "struct", desc: "Insert the keyword struct", row: "top")
        self.codeHotButton = makeHotButton(title: "class", desc: "Insert the keyword class", row: "top")
        self.codeHotButton = makeHotButton(title: "weak", desc: "Insert the keyword weak", row: "top")
        self.codeHotButton = makeHotButton(title: "bool", desc: "Insert the keyword bool", row: "top")
        
        horizHotStackView = UIStackView(arrangedSubviews: arrayOfHotButtons)
        horizHotStackView.axis = .horizontal
        horizHotStackView.distribution = .fillEqually
        horizHotStackView.alignment = .fill
        horizHotStackView.spacing = 10
        horizHotStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: ====> THE STACK VIEW Bottom Row
        horizOperatorStackView = UIStackView()
        horizOperatorStackView.axis = .horizontal
        horizOperatorStackView.distribution = .equalSpacing
        horizOperatorStackView.alignment = .leading
        horizOperatorStackView.spacing = 4
        horizOperatorStackView.translatesAutoresizingMaskIntoConstraints = false
        horizOperatorStackView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        self.view.addSubview(horizOperatorStackView)
        horizOperatorStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5.0).isActive = true
        horizOperatorStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        
        //MARK: ====> HOT Buttons Bottom Row
        self.parenHotButton = makeHotButton(title: "()", desc: "Insert left and right Paranthesis place cursor in the middle", row: "bottom")
        self.anglesHotButton = makeHotButton(title: "<>", desc: "Insert left and right angle brackets place cursor in the middle", row: "bottom")
        self.lessthanHotButton = makeHotButton(title: "<", desc: "Insert less than symbol", row: "bottom")
        self.greaterthanHotButton = makeHotButton(title: ">", desc: "Insert greater than symbol", row: "bottom")
        self.goesToHotButton = makeHotButton(title: "->", desc: "Insert -> symbol", row: "bottom")
        self.plusHotButton = makeHotButton(title: "+", desc: "Insert plus sign", row: "bottom")
        self.minusHotButton = makeHotButton(title: "-", desc: "Insert minus sign", row: "bottom")
        self.multiplyHotButton = makeHotButton(title: "*", desc: "Insert multiplication sign", row: "bottom")
        self.divideHotButton = makeHotButton(title: "/", desc: "Insert division sign", row: "bottom")
        self.uibuttonHotButton = makeHotButton(title: "UIButton", desc: "Insert the UIButton keyword", row: "bottom")
        self.uilabelHotButton = makeHotButton(title: "UILabel", desc: "Insert the UILabel keyword", row: "bottom")
        self.iboutletHotButton = makeHotButton(title: "IBOutlet", desc: "Insert the IBOutlet keyword", row: "bottom")
        self.ibactionHotButton = makeHotButton(title: "IBAction", desc: "Insert the IBAction keyword", row: "bottom")

        horizOperatorStackView = UIStackView(arrangedSubviews: arrayOfHotOperatorButtons)
        horizOperatorStackView.axis = .horizontal
        horizOperatorStackView.distribution = .fillEqually
        horizOperatorStackView.alignment = .fill
        horizOperatorStackView.spacing = 10
        horizOperatorStackView.translatesAutoresizingMaskIntoConstraints = false

        
        
        
        
        //MARK: ====> Fitting the Hot Button StackView into a UIScrollView
        hotButtonScrollView = UIScrollView()
        hotButtonScrollView.addSubview(horizHotStackView)
        horizHotStackView.leadingAnchor.constraint(equalTo: hotButtonScrollView.leadingAnchor).isActive = true
        horizHotStackView.trailingAnchor.constraint(equalTo: hotButtonScrollView.trailingAnchor).isActive = true
        horizHotStackView.bottomAnchor.constraint(equalTo: hotButtonScrollView.bottomAnchor).isActive = true
        horizHotStackView.topAnchor.constraint(equalTo: hotButtonScrollView.topAnchor).isActive = true
        
        hotOperatorScrollView = UIScrollView()
        hotOperatorScrollView.addSubview(horizOperatorStackView)
        horizOperatorStackView.leadingAnchor.constraint(equalTo: hotOperatorScrollView.leadingAnchor).isActive = true
        horizOperatorStackView.trailingAnchor.constraint(equalTo: hotOperatorScrollView.trailingAnchor).isActive = true
        horizOperatorStackView.bottomAnchor.constraint(equalTo: hotOperatorScrollView.bottomAnchor).isActive = true
        horizOperatorStackView.topAnchor.constraint(equalTo: hotOperatorScrollView.topAnchor).isActive = true
        
        arrayOfKeyboardRows += [hotButtonScrollView]
        arrayOfKeyboardRows += [hotOperatorScrollView]
        
        //MARK: =====> Making the keyboard ROW 1
        buildRegularKeyboard()
        horizKeyRow1.axis = .horizontal
        horizKeyRow1.distribution = .fillEqually
        horizKeyRow1.alignment = .fill
        horizKeyRow1.spacing = 4
        horizKeyRow1.translatesAutoresizingMaskIntoConstraints = false
        horizKeyRow1.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        arrayOfKeyboardRows += [horizKeyRow1]
        
        //MARK: =====> Making the keyboard ROW 2
        horizKeyRow2.axis = .horizontal
        horizKeyRow2.distribution = .fillEqually
        horizKeyRow2.alignment = .fill
        horizKeyRow2.spacing = 2
        horizKeyRow2.translatesAutoresizingMaskIntoConstraints = false
        horizKeyRow2.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        arrayOfKeyboardRows += [horizKeyRow2]

        //MARK: =====> Making the keyboard ROW 3
        horizKeyRow3.axis = .horizontal
        horizKeyRow3.distribution = .fillEqually
        horizKeyRow3.alignment = .fill
        horizKeyRow3.spacing = 4
        horizKeyRow3.translatesAutoresizingMaskIntoConstraints = false
        horizKeyRow3.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        arrayOfKeyboardRows += [horizKeyRow3]

        //MARK: =====> Making the keyboard ROW 4
        horizKeyRow4.axis = .horizontal
        horizKeyRow4.distribution = .fillProportionally
        horizKeyRow4.alignment = .fill
        horizKeyRow4.spacing = 4
        horizKeyRow4.translatesAutoresizingMaskIntoConstraints = false
        horizKeyRow4.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        arrayOfKeyboardRows += [horizKeyRow4]

        
        //MARK: ====> ADD The Vertical Stack to the View and Constrain it to the sides
        vertKeyboardStackView = UIStackView(arrangedSubviews: arrayOfKeyboardRows)
        vertKeyboardStackView.axis = .vertical
        vertKeyboardStackView.distribution = .fillEqually
        vertKeyboardStackView.spacing = 5
        vertKeyboardStackView.translatesAutoresizingMaskIntoConstraints = false
        vertKeyboardStackView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]

        self.view.addSubview(vertKeyboardStackView)
        vertKeyboardStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0).isActive = true
        vertKeyboardStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        vertKeyboardStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5.0).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    //makeHotButton is meant to create a new UIButton for our HotButtons array then add them to the array
    func makeHotButton(title: String, desc: String, row: String) -> UIButton{
        let button = UIButton(type: .system)
        let buttonBgColor: UIColor = UIColor(red: 41/255, green: 43/255, blue: 53/255, alpha: 1)
        var hotButtonTextColor = UIColor.white
        button.setTitle(NSLocalizedString(title, comment: desc), for: [])
        button.sizeToFit()
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)!
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = arrayOfHotButtons.count
        button.addTarget(self, action: #selector(hotAction), for: UIControlEvents.touchUpInside)
        button.layer.zPosition = 2
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.backgroundColor = buttonBgColor.cgColor
        switch title {
        case "var","let","func","enum","return","struct","class","weak","bool","code","UIButton","UILabel","IBOutlet","IBAction":
            hotButtonTextColor = UIColor(red: 240/255, green: 53/255, blue: 253/255, alpha: 1)
        case "\"\"":
            hotButtonTextColor = UIColor(red: 255/255, green: 1/255, blue: 1/255, alpha: 1)
        case "{}","[]","<>","()":
            hotButtonTextColor = UIColor.white
        default:
            hotButtonTextColor = UIColor.white
        }
        
        button.setTitleColor(hotButtonTextColor, for:[])
        
        if row == "top"
        {
            arrayOfHotButtons += [button]
        } else
        {
            arrayOfHotOperatorButtons += [button]
        }
        return button
    }
    
    //MARK: ===> Hot Button Action Function
    @objc func hotAction(sender: UIButton) {
        insertBetween = false
        addASpace = false
        wrapSpaces = false
        if let buttonTitle = sender.title(for: .normal) {
            switch buttonTitle {
            case "var","let","func","enum","return","struct","class","weak","bool","code","UIButton","UILabel","IBOutlet","IBAction":
                addASpace = true
            case "<",">","->","+","-","*","/":
                wrapSpaces = true
            case "\"\"":
                insertBetween = true
            case "{}","[]","<>","()":
                insertBetween = true
            default: break
            }
            //Sounds for the keys, tried UIInputViewAudioFeedback but had problems. this works
            AudioServicesPlaySystemSound(1104)
            print("Button \(buttonTitle) was clicked")
            if buttonTitle == "code" {
                self.textDocumentProxy.insertText("<\(buttonTitle)>")
                self.textDocumentProxy.insertText("</\(buttonTitle)> ")
                self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -8)
            } else if buttonTitle == "func" {
                self.textDocumentProxy.insertText("\(buttonTitle) ")
                self.textDocumentProxy.insertText("f: () {\r\n}")
                self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -9)
            } else if buttonTitle == "enum" {
                self.textDocumentProxy.insertText("\(buttonTitle) ")
                self.textDocumentProxy.insertText("e {\r\ncase c1, case c2\r\n}")
                self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -23)
            } else if buttonTitle == "struct" {
                self.textDocumentProxy.insertText("\(buttonTitle) ")
                self.textDocumentProxy.insertText("SomeStructure {\r\n//code\r\n}")
                self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -13)
            }else if buttonTitle == "class" {
                self.textDocumentProxy.insertText("\(buttonTitle) ")
                self.textDocumentProxy.insertText("SomeClass {\r\n//code\r\n}")
                self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -13)
            }else if buttonTitle == "UIButton" {
                self.textDocumentProxy.insertText(": \(buttonTitle)")
            }else if buttonTitle == "UILabel" {
                self.textDocumentProxy.insertText(": \(buttonTitle)")
            }else if buttonTitle == "IBOutlet" {
                self.textDocumentProxy.insertText("@\(buttonTitle) var name: type ")
            }else if buttonTitle == "IBAction" {
                self.textDocumentProxy.insertText("@\(buttonTitle) func name(_ sender: type?) { }")
                self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
            }
            else {
                if !wrapSpaces && !addASpace {
                    self.textDocumentProxy.insertText("\(buttonTitle)")
                }else if wrapSpaces {
                    self.textDocumentProxy.insertText(" \(buttonTitle) ")
                }else if addASpace {
                    self.textDocumentProxy.insertText("\(buttonTitle) ")
                }
            }

            if insertBetween {
                self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
            }
        }
    }
    
    
    //MARK: ===> KeyAction Function
    @objc func keyAction(sender: UIButton) {
        var workingTitle = ""
        if let buttonTitle = sender.title(for: .normal) {
            var addToText: Bool = true
            switch buttonTitle {
            case "⇧":
                addToText = false
                if shiftIsOn{
                    print("Shift is on, turning off")
                    changeKeyboardCase(goUpper: false)
                    shiftIsOn = false
                } else {
                    print("Shift is off, turning on")
                    changeKeyboardCase(goUpper: true)
                    shiftIsOn = true
                }
            case "del":
                self.textDocumentProxy.deleteBackward()
                addToText = false
            case "        space        ":
                workingTitle = " "
                self.textDocumentProxy.insertText("\(workingTitle)")
                addToText = false
            case "return":
                workingTitle = "\r\n"
                self.textDocumentProxy.insertText(workingTitle)
                addToText = false
            default:
                buttonsTextColor = UIColor.white
                insertBetween = false
            }
            //Sounds for the keys, tried UIInputViewAudioFeedback but had problems. this works
            AudioServicesPlaySystemSound(1104)
            if shiftIsOn && buttonTitle != "⇧"{
                workingTitle = buttonTitle.uppercased()
                shiftIsOn = false
                changeKeyboardCase(goUpper: false)
            } else {
                workingTitle = buttonTitle
            }
            if addToText {
                    print("Button \(workingTitle) was clicked")
                    self.textDocumentProxy.insertText("\(workingTitle)")
            }
        }
    }

    
    //MARK: ====> Building Regular Keyboard
    func buildRegularKeyboard() {
        //MARK: ====> ROW 1 of Keyboard
        let row1Array = ["q","w","e","r","t","y","u","i","o","p"]
        for key in row1Array {
            arrayOfKeysRow1 += [addRegularKey(title: key, desc: key)]
        }
        horizKeyRow1 = UIStackView(arrangedSubviews: arrayOfKeysRow1)
        
        //MARK: ====> ROW 2 of Keyboard
        let row2Array = ["a","s","d","f","g","h","j","k","l"]
        for key in row2Array {
            arrayOfKeysRow2 += [addRegularKey(title: key, desc: key)]
        }
        horizKeyRow2 = UIStackView(arrangedSubviews: arrayOfKeysRow2)

        //MARK: ====> ROW 3 of Keyboard
        let row3Array = ["⇧","z","x","c","v","b","n","m","del"]
        for key in row3Array {
            arrayOfKeysRow3 += [addRegularKey(title: key, desc: key)]
        }
        horizKeyRow3 = UIStackView(arrangedSubviews: arrayOfKeysRow3)

        //MARK: ====> ROW 4 of Keyboard
        let row4Array = ["=","😀",".","        space        ","return"]
        for key in row4Array {
            arrayOfKeysRow4 += [addRegularKey(title: key, desc: key)]
        }
        horizKeyRow4 = UIStackView(arrangedSubviews: arrayOfKeysRow4)
        
    }
    
    //MARK: ====> Add Regular Key
    func addRegularKey(title: String, desc: String) -> UIButton{
        let button = UIButton(type: .system)
        let buttonBgColor: UIColor = UIColor(red:91/255, green: 92/255, blue: 95/255, alpha: 1)
        button.setTitle(NSLocalizedString(title, comment: desc), for: [])
        button.sizeToFit()
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)!
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.tag = arrayOfHotButtons.count
        if title == "(){}" || title == "😀" {
            button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        } else {
            button.addTarget(self, action: #selector(keyAction), for: UIControlEvents.touchUpInside)
        }
        
        button.layer.zPosition = 2
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.backgroundColor = buttonBgColor.cgColor
        button.setTitleColor(buttonsTextColor, for:[])
        return button
    }
    
    //MARK: ====> Changing Keyboard Case
    func changeKeyboardCase(goUpper: Bool){
        for v in horizKeyRow1.arrangedSubviews {
            let b:UIButton = v as! UIButton
            if goUpper {
                let title = b.title(for: .normal)?.uppercased();
                b.setTitle(title, for: .normal);
            } else {
                let title = b.title(for: .normal)?.lowercased();
                b.setTitle(title, for: .normal);
            }
        }

        for v in horizKeyRow2.arrangedSubviews {
            let b:UIButton = v as! UIButton
            if goUpper {
                let title = b.title(for: .normal)?.uppercased();
                b.setTitle(title, for: .normal);
            } else {
                let title = b.title(for: .normal)?.lowercased();
                b.setTitle(title, for: .normal);
            }
        }

        for v in horizKeyRow3.arrangedSubviews {
            let b:UIButton = v as! UIButton
            if goUpper {
                let title = b.title(for: .normal)?.uppercased();
                b.setTitle(title, for: .normal);
            } else {
                let title = b.title(for: .normal)?.lowercased();
                b.setTitle(title, for: .normal);
            }
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
        //self.nextKeyboardButton.setTitleColor(textColor, for: [])
        
    }

}
