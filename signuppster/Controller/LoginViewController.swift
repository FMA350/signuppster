//
//  ViewController.swift
//  signuppster
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 09/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import UIKit
import CoreGraphics

class LoginViewController: UIViewController, sign {

    // Page Elements
    var emailView : InputField =  InputField()
    var passwordView : InputField = InputField()
    var headerLogo : UIImageView = UIImageView()
    var toSignUpButton : UIButton = UIButton(type: .system)
    
    let HEADER_IMAGE_NAME : String = "login.png"

    override func viewDidLoad() {
        //subviews handling
        setSubviewsFrames()
        setSubviewsProperties()
        addSubviews()
        //gesture handling
        self.hideKeyboardOnTap()
        
    }
    
    func addSubviews(){
        self.view.addSubview(emailView)
        self.view.addSubview(passwordView)
        self.view.addSubview(headerLogo)
        self.view.addSubview(toSignUpButton)
    }
    
    func setSubviewsFrames(){
        //declarations
        let screenSize: CGRect = UIScreen.main.bounds
        
        let headerImageWidth : CGFloat = screenSize.width*HEADER_IMAGE_WIDTH_PERCENTAGE
        let headerImageHeight : CGFloat = headerImageWidth
        let headerImageX : CGFloat = (screenSize.width-headerImageWidth)/2
        let headerImageY : CGFloat = screenSize.height*TOP_OFFSET_PERCENTAGE
        let headerFrame : CGRect = CGRect(x:headerImageX, y:headerImageY, width: headerImageWidth, height: headerImageHeight)

        let inputFieldWidth : CGFloat = screenSize.width*INPUT_FIELD_WIDTH_PERCENTAGE
        let inputFieldHeight : CGFloat = screenSize.height*INPUT_FIELD_HEIGHT_PERCENTAGE
        let headerInputOffsetY : CGFloat = screenSize.height*HEADER_INPUT_OFFSET_Y_PERCENTAGE
        let inputInputOffsetY : CGFloat = screenSize.height*INPUT_INPUT_OFFSET_Y_PERCENTAGE
        var inputFrame = CGRect(x: 10, y: headerImageY+headerImageHeight+headerInputOffsetY, width: inputFieldWidth, height: inputFieldHeight)
        //assignments
        headerLogo.frame = headerFrame
        emailView.frame = inputFrame
        inputFrame = inputFrame.offsetBy(dx: 0, dy: inputInputOffsetY)
        passwordView.frame = inputFrame
        inputFrame = inputFrame.offsetBy(dx: 0, dy: inputInputOffsetY)
        toSignUpButton.frame = inputFrame
    }
    
    func setSubviewsProperties(){
        //of header logo
        let image : UIImage = UIImage(named: HEADER_IMAGE_NAME)!;
        headerLogo.image = image
        //of email input field
        emailView.setProperties( imageName:"userunknown.png", placeholder: "Your Email", isPassword: false, keyboardType: .emailAddress, validatorType: .initDefault)
        //of password input field
        passwordView.setProperties( imageName: "password.png", placeholder: "Your Password", isPassword:true, keyboardType: .emailAddress, validatorType: .initDefault)
        //of button
        toSignUpButton.setTitle("Don't have an account yet? Sign Up!", for: .normal)
        toSignUpButton.addTarget(self, action: #selector(toSignUp), for: .touchUpInside)
        
    }
    
    
 @objc func toSignUp(){
        self.performSegue(withIdentifier: "segueToSignup", sender: self)
    }
}

