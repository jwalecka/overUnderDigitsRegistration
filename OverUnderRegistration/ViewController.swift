//
//  ViewController.swift
//  OverUnderRegistration
//
//  Created by John Walecka on 5/18/16.
//  Copyright © 2016 John Walecka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let nextButton = UILabel()
    
    var viewWidth = CGFloat()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewWidth = self.view.frame.width
        setObjects()
        //firstNameTextField.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setObjects() {
        let navHeight = CGFloat(64)
        let betCellMainColor = UIColor(red: 75.0/255.0, green:126.0/255.0, blue:231.0/255.0, alpha: 1)
        
        
        let titleOffset = CGFloat(10)
        let enterNameLabelOrigin = CGPoint(x: titleOffset, y: navHeight)
        let enterNameLabelSize = CGSize(width: self.view.frame.width - titleOffset, height: 45)
        let enterNameLabel = UILabel(frame: CGRect(origin: enterNameLabelOrigin, size: enterNameLabelSize))
        enterNameLabel.font = UIFont.systemFontOfSize(22, weight: UIFontWeightLight)
        enterNameLabel.textColor = betCellMainColor
        enterNameLabel.text = "Enter your first and last name"
        self.view.addSubview(enterNameLabel)
        
        let borderSize = CGSize(width: viewWidth, height: 1)
        let topLabelBorderOrigin = CGPoint(x: 0, y: enterNameLabelOrigin.y + enterNameLabelSize.height - borderSize.height)
        let border = UIView(frame: CGRect(origin: topLabelBorderOrigin, size: borderSize))
        border.backgroundColor = betCellMainColor
        self.view.addSubview(border)
        
        let textFieldOffset = CGFloat(10)
        let nameTextFieldSize = CGSize(width: viewWidth - 2*textFieldOffset, height: 45)
        
        let firstNameTextFieldOrigin = CGPoint(x: textFieldOffset, y: enterNameLabelOrigin.y + enterNameLabelSize.height)
        firstNameTextField.frame = CGRect(origin: firstNameTextFieldOrigin, size: nameTextFieldSize)
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.tag = 0
        firstNameTextField.delegate = self
        firstNameTextField.font = UIFont.systemFontOfSize(22, weight: UIFontWeightLight)
        self.view.addSubview(firstNameTextField)
        
        let firstTextFieldBorderOrigin = CGPoint(x: 0, y: firstNameTextFieldOrigin.y + nameTextFieldSize.height - borderSize.height)
        let firstTextFieldBorder = UIView(frame: CGRect(origin: firstTextFieldBorderOrigin, size: borderSize))
        firstTextFieldBorder.backgroundColor = betCellMainColor
        self.view.addSubview(firstTextFieldBorder)
        
        let lastNameTextFieldOrigin = CGPoint(x: textFieldOffset, y: firstNameTextFieldOrigin.y + nameTextFieldSize.height)
        lastNameTextField.frame = CGRect(origin: lastNameTextFieldOrigin, size: nameTextFieldSize)
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.tag = 1
        lastNameTextField.delegate = self
        lastNameTextField.font = UIFont.systemFontOfSize(22, weight: UIFontWeightLight)
        self.view.addSubview(lastNameTextField)
        
        let lastNameTextFieldBorderOrigin = CGPoint(x: 0, y: lastNameTextFieldOrigin.y + nameTextFieldSize.height - borderSize.height)
        let lastNameTextFieldBorder = UIView(frame: CGRect(origin: lastNameTextFieldBorderOrigin, size: borderSize))
        lastNameTextFieldBorder.backgroundColor = betCellMainColor
        self.view.addSubview(lastNameTextFieldBorder)
        
        let buttonOffsetHoriz = CGFloat(40)
        let buttonOffsetVert = CGFloat(30)
        let nextButtonOrigin = CGPoint(x: buttonOffsetHoriz, y: lastNameTextFieldOrigin.y + nameTextFieldSize.height + buttonOffsetVert)
        let nextButtonSize = CGSize(width: viewWidth - 2*buttonOffsetHoriz, height: 40)
        nextButton.frame = CGRect(origin: nextButtonOrigin, size: nextButtonSize)
        nextButton.layer.cornerRadius = 0.2*nextButtonSize.height
        nextButton.clipsToBounds = true
        nextButton.backgroundColor = betCellMainColor
        nextButton.font = UIFont.systemFontOfSize(26, weight: UIFontWeightLight)
        nextButton.textAlignment = NSTextAlignment.Center
        nextButton.textColor = UIColor.whiteColor()
        nextButton.text = "Next"
        self.view.addSubview(nextButton)
        
        let tap = UITapGestureRecognizer(target: self, action: "goToNextView")
        nextButton.userInteractionEnabled = true
        nextButton.addGestureRecognizer(tap)
        
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.textColor = betCellMainColor
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.textColor = UIColor.blackColor()
    }
    
    @IBAction func goToNextView() {
        lastNameTextField.textColor = betCellMainColor
        self.performSegueWithIdentifier("goToNumberEntry", sender: self)
    }


}

