//
//  NumberEntryViewController.swift
//  OverUnderRegistration
//
//  Created by John Walecka on 5/18/16.
//  Copyright © 2016 John Walecka. All rights reserved.
//

import UIKit

class NumberEntryViewController: UIViewController, UITextFieldDelegate {

    let numberEntryTextField = UITextField()
    let codeEntryTextField = UITextField()
    let confirmationButton = UILabel()
    var phoneFormatter = PhoneNumberFormatter()
    let warningLabel = UILabel()
    
    let numberBorder = UIView()
    let codeBorder = UIView()
    
    var confirmationButtonOrigin = CGPoint()
    var confirmationButtonOriginMove = CGPoint()
    
    var codeEntryTextFieldOriginInit = CGPoint()
    var codeEntryTextFieldOrigin = CGPoint()
    
    var viewWidth = CGFloat()
    
    var lastCode = NSMutableAttributedString()
    var codes = [NSMutableAttributedString: NSMutableAttributedString]()
    var attributedPlaceholder = NSMutableAttributedString()
    
    var buttonMoved = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWidth = self.view.frame.width
        setObjects()
        formatField(numberEntryTextField)
        attributedPlaceholder = NSMutableAttributedString(string: "- - -  - - -")
        let range = NSRange(location: 0, length: attributedPlaceholder.string.length)
        attributedPlaceholder.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: range)
        lastCode = attributedPlaceholder
        //numberEntryTextField.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setObjects() {
        let navHeight = CGFloat(64)
        let betCellMainColor = UIColor(red: 75.0/255.0, green:126.0/255.0, blue:231.0/255.0, alpha: 1)
        let redColor = UIColor(red: 213.0/255, green: 70.0/255, blue: 70.0/255, alpha: 1)
        
        
        let titleOffset = CGFloat()
        let enterNumberLabelOrigin = CGPoint(x: titleOffset, y: navHeight)
        let enterNumberLabelSize = CGSize(width: self.view.frame.width - titleOffset, height: 45)
        let enterNumberLabel = UILabel(frame: CGRect(origin: enterNumberLabelOrigin, size: enterNumberLabelSize))
        enterNumberLabel.font = UIFont.systemFontOfSize(22, weight: UIFontWeightLight)
        enterNumberLabel.textColor = betCellMainColor
        enterNumberLabel.text = "Enter your phone number"
        enterNumberLabel.textAlignment = NSTextAlignment.Center
        enterNumberLabel.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(enterNumberLabel)
        
        let borderSize = CGSize(width: viewWidth, height: 1)
        let borderOrigin = CGPoint(x: 0, y: enterNumberLabelSize.height - borderSize.height)
        let border = UIView(frame: CGRect(origin: borderOrigin, size: borderSize))
        border.backgroundColor = betCellMainColor
        enterNumberLabel.addSubview(border)
        
        let textFieldOffset = CGFloat(10)
        let textFieldSize = CGSize(width: viewWidth, height: 55)
        
        let numberEntryTextFieldOrigin = CGPoint(x: 0, y: enterNumberLabelOrigin.y + enterNumberLabelSize.height)
        numberEntryTextField.frame = CGRect(origin: numberEntryTextFieldOrigin, size: textFieldSize)
        numberEntryTextField.textAlignment = NSTextAlignment.Center
        numberEntryTextField.placeholder = "Your Number"
        numberEntryTextField.tag = 0
        numberEntryTextField.delegate = self
        numberEntryTextField.font = UIFont.systemFontOfSize(30, weight: UIFontWeightLight)
        numberEntryTextField.userInteractionEnabled = true
        numberEntryTextField.addTarget(self, action: "formatField:", forControlEvents: UIControlEvents.AllEditingEvents)
        numberEntryTextField.keyboardType = UIKeyboardType.DecimalPad
        numberEntryTextField.backgroundColor = UIColor.whiteColor()
        numberEntryTextField.textColor = UIColor.lightGrayColor()
        self.view.addSubview(numberEntryTextField)
        
        
        let textFieldBorderSize = CGSize(width: self.view.frame.width, height: 2.5)
        let numberBorderOrigin = CGPoint(x: 0, y: textFieldSize.height - textFieldBorderSize.height)
        numberBorder.frame = CGRect(origin: numberBorderOrigin, size: textFieldBorderSize)
        numberBorder.backgroundColor = betCellMainColor.colorWithAlphaComponent(0.5)
        numberEntryTextField.addSubview(numberBorder)
        
        
        let codeTextFieldSize = CGSize(width: viewWidth, height: 55)
        
        codeEntryTextFieldOriginInit = CGPoint(x: 0, y: numberEntryTextFieldOrigin.y + textFieldSize.height - codeTextFieldSize.height)
        codeEntryTextFieldOrigin = CGPoint(x: 0, y: numberEntryTextFieldOrigin.y + textFieldSize.height)
        codeEntryTextField.frame = CGRect(origin: codeEntryTextFieldOriginInit, size: codeTextFieldSize)
        codeEntryTextField.textAlignment = NSTextAlignment.Center
        codeEntryTextField.placeholder = "Enter Code"
        codeEntryTextField.tag = 1
        codeEntryTextField.delegate = self
        codeEntryTextField.font = UIFont.systemFontOfSize(32, weight: UIFontWeightLight)
        codeEntryTextField.userInteractionEnabled = true
        codeEntryTextField.addTarget(self, action: "formatCodeField:", forControlEvents: UIControlEvents.AllEditingEvents)
        codeEntryTextField.keyboardType = UIKeyboardType.DecimalPad
        codeEntryTextField.tintColor = UIColor.clearColor()
        codeEntryTextField.textColor = UIColor.lightGrayColor()
        self.view.addSubview(codeEntryTextField)
        self.view.sendSubviewToBack(codeEntryTextField)
        
        let codeBorderOrigin = CGPoint(x: 0, y: codeTextFieldSize.height - textFieldBorderSize.height)
        codeBorder.frame = CGRect(origin: codeBorderOrigin, size: textFieldBorderSize)
        codeBorder.backgroundColor = betCellMainColor.colorWithAlphaComponent(0.5)
        codeEntryTextField.addSubview(codeBorder)
        
        let buttonOffsetHoriz = CGFloat(20)
        let buttonOffsetVert = CGFloat(30)
        let confirmationButtonOrigin = CGPoint(x: buttonOffsetHoriz, y: numberEntryTextFieldOrigin.y + textFieldSize.height + buttonOffsetVert)
        let confirmationButtonSize = CGSize(width: viewWidth - 2*buttonOffsetHoriz, height: 40)
        confirmationButton.frame = CGRect(origin: confirmationButtonOrigin, size: confirmationButtonSize)
        confirmationButton.layer.cornerRadius = 0.2*confirmationButtonSize.height
        confirmationButton.clipsToBounds = true
        confirmationButton.backgroundColor = betCellMainColor
        confirmationButton.font = UIFont.systemFontOfSize(18, weight: UIFontWeightMedium)
        confirmationButton.textAlignment = NSTextAlignment.Center
        confirmationButton.textColor = UIColor.whiteColor()
        confirmationButton.text = "Send confirmation code"
        self.view.addSubview(confirmationButton)
        
        let tap = UITapGestureRecognizer(target: self, action: "checkNumber")
        confirmationButton.userInteractionEnabled = true
        confirmationButton.addGestureRecognizer(tap)
        
        let labelOffsetHoriz = CGFloat(30)
        let labelOffsetVert = CGFloat(10)
        let labelSize = CGSize(width: viewWidth - 2*labelOffsetHoriz, height: 40)
        let labelOrigin = CGPoint(x: labelOffsetHoriz, y: confirmationButtonOrigin.y + confirmationButtonSize.height + labelOffsetVert)
        warningLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
        warningLabel.textAlignment = NSTextAlignment.Center
        warningLabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        warningLabel.textColor = redColor
        warningLabel.text = "Invalid phone number"
        self.view.addSubview(warningLabel)
        warningLabel.hidden = true
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let borderHeight = CGFloat(2.5)
        if textField.tag == 0 {
            textField.textColor = betCellMainColor
            numberBorder.frame = CGRect(origin: CGPoint(x: 0, y: textField.frame.height - borderHeight), size: CGSize(width: viewWidth, height: borderHeight))
            numberBorder.backgroundColor = betCellMainColor.colorWithAlphaComponent(0.5)
        }
        else if textField.tag == 1 {
            codeBorder.frame = CGRect(origin: CGPoint(x: 0, y: textField.frame.height - borderHeight), size: CGSize(width: viewWidth, height: borderHeight))
            codeBorder.backgroundColor = betCellMainColor.colorWithAlphaComponent(0.5)
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let borderHeight = CGFloat(2)
        if textField.tag == 0 {
            textField.placeholder = nil
            textField.textColor = UIColor.grayColor()
            numberBorder.frame = CGRect(origin: CGPoint(x: 0, y: textField.frame.height - borderHeight), size: CGSize(width: viewWidth, height: borderHeight))
            numberBorder.backgroundColor = betCellMainColor
        }
        else if textField.tag == 1 {
            textField.font = UIFont.systemFontOfSize(40, weight: UIFontWeightLight)
            codeBorder.frame.size.height = CGFloat(2.0)
            textField.font = UIFont.systemFontOfSize(40, weight: UIFontWeightLight)
            textField.placeholder = "- - -  - - -"
            codeBorder.frame = CGRect(origin: CGPoint(x: 0, y: textField.frame.height - borderHeight), size: CGSize(width: viewWidth, height: borderHeight))
            codeBorder.backgroundColor = betCellMainColor
            codeEntryTextField.attributedPlaceholder = attributedPlaceholder
        }
        
    }
    
    
    @IBAction func goToNextView() {
        numberEntryTextField.textColor = betCellMainColor
    }
    
    @IBAction func formatField(sender: UITextField) {
        print("formatting field")
        if let text = sender.text {
            sender.text = phoneFormatter.format(text)
            if text.length == 14 {
                sender.textColor = betCellMainColor
            }
            else {
                sender.textColor = UIColor.grayColor()
            }
        }
    }
    
    @IBAction func formatCodeField(sender: UITextField) {
        if let text = sender.text {
            sender.attributedText = formatCode(text)
            if lastCode.string.onlyCharacters("0123456789").length == 6 {
                sender.textColor = betCellMainColor
            }
            else {
                sender.textColor = UIColor.lightGrayColor()
            }
        }
    }
    
    
    @IBAction func checkNumber() {
        if let text = numberEntryTextField.text {
            if phoneFormatter.isValid(text) {
                
                numberEntryTextField.resignFirstResponder()
                if buttonMoved == false {
                    UIView.animateWithDuration(0.6, animations: {
                        let textFieldSize = self.codeEntryTextField.frame.size
                        self.codeEntryTextField.frame = CGRect(origin: self.codeEntryTextFieldOrigin, size: textFieldSize)
                        
                        let buttonSize = self.confirmationButton.frame.size
                        let newButtonOrigin = CGPoint(x: self.confirmationButton.frame.origin.x, y: self.confirmationButton.frame.origin.y + textFieldSize.height)
                        self.confirmationButton.frame = CGRect(origin: newButtonOrigin, size: buttonSize)
                        
                        }, completion: { finished in
                            self.confirmationButton.text = "Resend confirmation code"
                            self.buttonMoved = true
                            
                    })
                }

            }
            else {
                warningLabel.hidden = false
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.warningLabel.hidden = true
                }
            }
        }
    }
    
    func formatCode(code: String) -> NSMutableAttributedString {
        let numericText = code.onlyCharacters("0123456789")
        let lastNumericText = lastCode.string.onlyCharacters("0123456789")
    
        if numericText.length > lastNumericText.length {
            if numericText.length < 7 {
                let newCode = buildString(numericText)
                codes[newCode] = lastCode
                lastCode = newCode
                return newCode
            }
            else {
                return lastCode
            }
        
        }
        else {
            if numericText.length > 0 {
                if let updatedCode = codes[lastCode] {
                    print("updated code: \(updatedCode)")
                    codes.removeValueForKey(lastCode)
                    lastCode = updatedCode
                    return updatedCode
                }
            }
            
        }
        return NSMutableAttributedString()
        
    }
    
    func buildString(numericText: String) -> NSMutableAttributedString {
        
        let codeLength = Int(6)
        var substring = NSMutableAttributedString()
        let attributedString = NSMutableAttributedString()
        
        for var i = 0; i < numericText.length; i++ {
            print("i == \(i)")
            let newNumber = numericText.subscriptString(i)
            print("new number: \(newNumber)")
            if i != 2 && i != 6 {
                substring = NSMutableAttributedString(string: "\(newNumber) ")
            }
            else if i == 2 {
                print("i equal to 2")
                substring = NSMutableAttributedString(string: "\(newNumber)  ")
            }
            else if i == 5 {
                substring = NSMutableAttributedString(string: "\(newNumber)")
            }
            
            //let subString = NSMutableAttributedString(string: "\(numericText[i])")
            
            print("length: \(substring.length)")
            attributedString.appendAttributedString(substring)
            
        }
        for var i = numericText.length; i < codeLength; i++ {
            print("i == \(i)")
            if i != 2 && i != 6 {
                substring = NSMutableAttributedString(string: "- ")
            }
            else if i == 2 {
                print("i equal to 2")
                substring = NSMutableAttributedString(string: "-  ")
            }
            else if i == 5 {
                substring = NSMutableAttributedString(string: "-")
            }
            
            //let subString = NSMutableAttributedString(string: "\(numericText[i])")
            print("length: \(substring.length)")
            attributedString.appendAttributedString(substring)
        }
        return attributedString

    }
    


}

extension String {
    
    func subscriptString(i: Int) -> String {
        let char = self[self.startIndex.advancedBy(i)]
        return String(char)
    }
    
//    subscript (i: Int) -> Character {
//        return self[self.startIndex.advancedBy(i)]
//    }
//    
//    subscript (i: Int) -> String {
//        return String(self[i] as Character)
//    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}
