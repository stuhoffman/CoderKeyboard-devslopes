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
    @IBOutlet var bracesHotButton: UIButton!
    //MARK: ====> Vars
//    var bracesHotButton: UIButton!
    var bracketsHotButton: UIButton!
    var varHotButton: UIButton!
    var letHotButton: UIButton!
    var quoteHotButton: UIButton!
    var codeHotButton: UIButton!
    var horizSwipeStackView: UIStackView!
    var horizLabelStackView: UIStackView!
    var horizHotStackView: UIStackView!
    var horizKeyRow1: UIStackView!
    var horizKeyRow2: UIStackView!
    var horizKeyRow3: UIStackView!
    var horizKeyRow4: UIStackView!
    var vertKeyboardStackView: UIStackView!
    var hotButtonScrollView: UIScrollView!
    var arrayOfHotButtons: [UIButton] = []
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
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    func importButtonData() {
        print("Starting loadData()")
        if let path = Bundle.main.path(forResource:"buttons", ofType: "plist"){
            let dict:NSDictionary = NSDictionary(contentsOfFile: path)!
            if (dict.object(forKey: "buttons") != nil) {
                if let buttonDict:[String : Any] = dict.object(forKey: "buttons") as? [String : Any] {
                    for (key, value) in buttonDict {
                        print("Working: \(key)")
                        if let buttonData:[String : Any] = value as? [String : Any] {
                            var btnLeadingSpace:Bool!
                            var btnName:String!
                            var btnDisplay:String!
                            var btnImageName:String!
                            var btnText:String!
                            var btnCurrentPosition:String!
                            var btnbackupLength:Int = 0
                            var btnHasTrailingSpace:Bool = false
                            var btnType:String!
                            var btnStartingPosition:String!
                            for (key, value) in buttonData {
                                print("Key = \(key) Value = \(value)")
                                switch key {
                                case "leadingspace":
                                   btnLeadingSpace = value as! Bool
                                case "name":
                                   btnName = value as! String
                                case "display":
                                   btnDisplay = value as! String
                                case "imagename":
                                    btnImageName = value as! String
                                case "text":
                                    btnText =  value as! String
                                case "currentposition":
                                    btnCurrentPosition = value as! String
                                case "backuplength":
                                    btnbackupLength = value as! Int
                                case "trailingspace":
                                    btnHasTrailingSpace = value as! Bool
                                case "type":
                                    btnType = value as! String
                                case "startingposition":
                                    btnStartingPosition = value as! String
                                default: break
                                    
                                }//end switch
                            }//end for loop on buttonData
                            makeHotButton(leadingSpace: btnLeadingSpace, name: btnName, display: btnDisplay, imageName: btnImageName, text: btnText, currentPosition: btnCurrentPosition, backupLength: btnbackupLength, hasTrailingSpace: btnHasTrailingSpace, type: btnType, startingPosition: btnStartingPosition )
                        }//end buttonData
                    
                    }
                }
            }
            
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let viewBgColor: UIColor = UIColor(red: 63/255, green: 64/255, blue: 68/255, alpha: 1)
        let swipeBgColor: UIColor = UIColor(red: 41/255, green: 43/255, blue: 53/255, alpha: 1)
        //this will be where we load all the buttons
        importButtonData()
       
        //MARK: ===> Swipe Stack View
        /*The trick here is to get a background color for a UIStackView you need to:
         1. Create a UIView
         2. Set its bounds to the same size as the StackView
         3. Set MaskingConstraints to fals
         4. Set autoresizing to flexibleTopMargin and flexibleWidth
         5. Set the sub views backgroundColor
         6. add the subview to the StackView.
         7. Set the anchors for the sub view.
        */
        let swipeButton: UIButton = UIButton()
        swipeButton.setTitle(NSLocalizedString("☟SWIPE DOWN FOR MORE", comment: "Swipe Down For More"), for: [])
        swipeButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 8)!
        swipeButton.translatesAutoresizingMaskIntoConstraints = false
        horizSwipeStackView = UIStackView()
        let swipeBgView = UIView(frame: horizSwipeStackView.bounds)
        swipeBgView.translatesAutoresizingMaskIntoConstraints = false
        swipeBgView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        swipeBgView.backgroundColor = swipeBgColor
        horizSwipeStackView.addSubview(swipeBgView)
        swipeBgView.topAnchor.constraint(equalTo: horizSwipeStackView.topAnchor).isActive = true
        swipeBgView.bottomAnchor.constraint(equalTo: horizSwipeStackView.bottomAnchor).isActive = true
        swipeBgView.leftAnchor.constraint(equalTo: horizSwipeStackView.leftAnchor).isActive = true
        swipeBgView.rightAnchor.constraint(equalTo: horizSwipeStackView.rightAnchor).isActive = true
        //Carry on with the StackView.
        horizSwipeStackView.addArrangedSubview(swipeButton)
        horizSwipeStackView.axis = .horizontal
        horizSwipeStackView.distribution = .fillEqually
        horizSwipeStackView.alignment = .center
        horizSwipeStackView.spacing = 4
        horizSwipeStackView.translatesAutoresizingMaskIntoConstraints = false
        horizSwipeStackView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        self.view.addSubview(horizSwipeStackView)
        horizSwipeStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5.0).isActive = true
        horizSwipeStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        horizSwipeStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5.0).isActive = true
        
        let recentButton: UIButton = UIButton()
        recentButton.setTitle(NSLocalizedString("RECENT", comment: "Recently Used Buttons"), for: [])
        recentButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 8)!
        recentButton.translatesAutoresizingMaskIntoConstraints = false
        horizLabelStackView = UIStackView(arrangedSubviews: [recentButton])
        horizLabelStackView.axis = .horizontal
        horizLabelStackView.distribution = .fill
        horizLabelStackView.alignment = .leading
        horizLabelStackView.spacing = 4
        horizLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        horizLabelStackView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        self.view.addSubview(horizLabelStackView)
        horizLabelStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0).isActive = true
        horizLabelStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        
        self.view.backgroundColor = viewBgColor
        
        //MARK: ====> HOT Buttons
//        self.bracesHotButton = makeHotButton(title: "{}", desc: "Insert left and right Braces place cursor in the middle")
//        self.bracketsHotButton = makeHotButton(title: "[]", desc: "Insert left and right Brackets place cursor in the middle")
//        self.varHotButton = makeHotButton(title: "var", desc: "Insert var keyword place cursor after the word var")
//        self.letHotButton = makeHotButton(title: "let", desc: "Insert let keyword place cursor after the word let")
//        self.quoteHotButton = makeHotButton(title: "\"\"", desc: "Insert left and right quotes place cursor in the middle")
//        self.codeHotButton = makeHotButton(title: "code", desc: "Insert code keyword place cursor after the word code")
//        self.codeHotButton = makeHotButton(title: "func", desc: "Insert the keyword func")
//        self.codeHotButton = makeHotButton(title: "enum", desc: "Insert the keyword enum")
//        self.codeHotButton = makeHotButton(title: "return", desc: "Insert the keyword return")
//        self.codeHotButton = makeHotButton(title: "struct", desc: "Insert the keyword struct")
//        self.codeHotButton = makeHotButton(title: "class", desc: "Insert the keyword class")
//        self.codeHotButton = makeHotButton(title: "weak", desc: "Insert the keyword weak")
//        self.codeHotButton = makeHotButton(title: "bool", desc: "Insert the keyword bool")
        
        //MARK: ====> THE STACK VIEW
        horizHotStackView = UIStackView(arrangedSubviews: arrayOfHotButtons)
        horizHotStackView.axis = .horizontal
        horizHotStackView.distribution = .fillEqually
        horizHotStackView.alignment = .fill
        horizHotStackView.spacing = 10
        horizHotStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: ====> Fitting the Hot Button StackView into a UIScrollView
        hotButtonScrollView = UIScrollView()
        hotButtonScrollView.addSubview(horizHotStackView)
        horizHotStackView.leadingAnchor.constraint(equalTo: hotButtonScrollView.leadingAnchor).isActive = true
        horizHotStackView.trailingAnchor.constraint(equalTo: hotButtonScrollView.trailingAnchor).isActive = true
        horizHotStackView.bottomAnchor.constraint(equalTo: hotButtonScrollView.bottomAnchor).isActive = true
        horizHotStackView.topAnchor.constraint(equalTo: hotButtonScrollView.topAnchor).isActive = true
        
        arrayOfKeyboardRows += [hotButtonScrollView]
        
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
        vertKeyboardStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0).isActive = true
        vertKeyboardStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        vertKeyboardStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5.0).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    
    //makeHotButton is meant to create a new UIButton for our HotButtons array then add them to the array
    func makeHotButton(leadingSpace: Bool, name:String, display: String, imageName: String, text: String, currentPosition: String, backupLength: Int, hasTrailingSpace: Bool, type: String, startingPosition: String ){
        let button = UIButton(type: .system)
        let image = UIImage(named: imageName)
        button.setBackgroundImage(image, for: [])
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hotAction), for: UIControlEvents.touchUpInside)
        button.layer.zPosition = 2
        button.layer.cornerRadius = 4
        //button.layer.borderWidth = 1
        
        arrayOfHotButtons += [button]
    }
    
    //MARK: ===> Hot Button Action Function
    @objc func hotAction(sender: UIButton) {
        insertBetween = false
        addASpace = false
        if let buttonTitle = sender.title(for: .normal) {
            switch buttonTitle {
            case "var","let","func","enum","return","struct","class","weak","bool","code":
                addASpace = true
            case "\"\"":
                insertBetween = true
            case "{}","[]":
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
            }
            else {
                self.textDocumentProxy.insertText("\(buttonTitle)")
                if addASpace {
                    self.textDocumentProxy.insertText(" ")
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
