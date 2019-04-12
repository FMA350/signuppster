//
//  SignupViewController.swift
//  signuppster
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 09/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import UIKit
import CoreGraphics
import PopupDialog



class SignupViewController: UIViewController, sign {
    var headerLogo : UIImageView = UIImageView()
    
    var usernameField : InputField = InputField()
    var emailField : InputField = InputField()
    var password1Field : InputField = InputField()
    var password2Field : InputField = InputField()
    var genderLabel : UILabel = UILabel()
    var genderSlider : UISlider = UISlider()
    
    var signUpButton : UIButton = UIButton(type: .system)
    var toLoginButton : UIButton = UIButton(type: .system)

    let HEADER_IMAGE_NAME : String = "signup.png"
    
    override func viewDidLoad() {
        //subviews handling
        setSubviewsFrames()
        setSubviewsProperties()
        addSubviews()
        //gesture handling
        self.hideKeyboardOnTap()
        
    }
    
    
    func setSubviewsFrames(){
        
        let elementsAboveButton : CGFloat = 6
        //declarations
        let screenSize: CGRect = UIScreen.main.bounds
        
        let headerImageWidth : CGFloat = screenSize.width*HEADER_IMAGE_WIDTH_PERCENTAGE
        let headerImageHeight : CGFloat = headerImageWidth
        let headerImageX : CGFloat = (screenSize.width-headerImageWidth)/2
        let headerImageY : CGFloat = screenSize.height*TOP_OFFSET_PERCENTAGE
        let headerFrame : CGRect = CGRect(x:headerImageX, y:headerImageY, width: headerImageWidth, height: headerImageHeight)
        
        let headerInputOffsetY : CGFloat = screenSize.height*HEADER_INPUT_OFFSET_Y_PERCENTAGE
        let inputInputOffsetY : CGFloat = screenSize.height*INPUT_INPUT_OFFSET_Y_PERCENTAGE

        let inputFieldWidth : CGFloat = screenSize.width*INPUT_FIELD_WIDTH_PERCENTAGE
        let inputFieldHeight : CGFloat = screenSize.height*INPUT_FIELD_HEIGHT_PERCENTAGE
        let inputFieldY : CGFloat = headerImageY+headerImageHeight+headerInputOffsetY
        var inputFrame = CGRect(x: LEFT_BORDER, y: inputFieldY, width: inputFieldWidth, height: inputFieldHeight)
        
        let buttonWidth : CGFloat = screenSize.width*INPUT_FIELD_WIDTH_PERCENTAGE
        let buttondHeight : CGFloat = screenSize.height*INPUT_FIELD_HEIGHT_PERCENTAGE
        let buttonbuttonOffsetY : CGFloat = screenSize.height*BUTTON_BUTTON_OFFSET_Y_PERCENTAGE
        let buttonY : CGFloat = inputFieldY + (inputInputOffsetY)*elementsAboveButton
        var buttonFrame = CGRect(x: LEFT_BORDER, y: buttonY, width: buttonWidth, height: buttondHeight)
        
        headerLogo.frame = headerFrame
        usernameField.frame = inputFrame
        inputFrame = inputFrame.offsetBy(dx: 0, dy: inputInputOffsetY)
        emailField.frame = inputFrame
        inputFrame = inputFrame.offsetBy(dx: 0, dy: inputInputOffsetY)
        password1Field.frame = inputFrame
        inputFrame = inputFrame.offsetBy(dx: 0, dy: inputInputOffsetY)
        password2Field.frame = inputFrame
        inputFrame = inputFrame.offsetBy(dx: 0, dy: inputInputOffsetY)
        genderLabel.frame = inputFrame
        inputFrame = inputFrame.offsetBy(dx: 0, dy: inputInputOffsetY)
        genderSlider.frame = inputFrame
        inputFrame = inputFrame.offsetBy(dx: 0, dy: inputInputOffsetY)
        signUpButton.frame = buttonFrame
        buttonFrame = buttonFrame.offsetBy(dx: 0, dy: buttonbuttonOffsetY)
        toLoginButton.frame = buttonFrame
        
        
    }
    
    func setSubviewsProperties(){
        headerLogo.image = UIImage(named: HEADER_IMAGE_NAME)!;
        //text fields
        usernameField.setProperties(imageName: "userunknown.png", placeholder: "Choose your username", isPassword: false, keyboardType: .default, validatorType: .username)
        emailField.setProperties(imageName: "email.png", placeholder: "Your Email Address", isPassword: false, keyboardType: .emailAddress, validatorType: .email)
        password1Field.setProperties(imageName: "password.png", placeholder: "Choose your password", isPassword: true, keyboardType: .namePhonePad, validatorType: .password)
        password2Field.setProperties(imageName: "password.png", placeholder: "repeat your password", isPassword: true, keyboardType: .namePhonePad, validatorType: .password)
        
        //Gender
        genderLabel.text = "Gender : Select"
        genderSlider.maximumValue = 100
        genderSlider.minimumValue = 0
        genderSlider.value = 50
        genderSlider.isContinuous = true
        genderSlider.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
        //buttons
        signUpButton.setTitle("Signup now!", for: .normal)
        signUpButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
        toLoginButton.setTitle("Not your first time? Login!", for: .normal)
        toLoginButton.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
    }
    
    func addSubviews(){
        self.view.addSubview(headerLogo)
        self.view.addSubview(usernameField)
        self.view.addSubview(emailField)
        self.view.addSubview(password1Field)
        self.view.addSubview(password2Field)
        self.view.addSubview(genderLabel)
        self.view.addSubview(genderSlider)
        self.view.addSubview(signUpButton)
        self.view.addSubview(toLoginButton)
        
    }
    
    @objc func toLogin(){
        self.dismiss(animated: true) {
        }
    }
    
    func signupValidation(){
        //let's check that every field has been validated at the InputFieldLevel
        var message : String = ""
        if !usernameField.isValidated(){
            if let msg = usernameField.getValidationMessage(){
                message += msg
            }
            else{//field is untouched
                 usernameField.setErrorBorder()
                 message += "The username field is empty!\n"
            }
        }
        if !emailField.isValidated(){
            if let msg = emailField.getValidationMessage(){
                message += msg
            }
            else{//field is untouched
                emailField.setErrorBorder()
                message += "The email field is empty!\n"
            }
        }
        if !password1Field.isValidated(){
            if let msg = password1Field.getValidationMessage(){
                message += msg
            }
            else{//field is untouched
                password1Field.setErrorBorder()
                password2Field.setErrorBorder()
                //need to set password2Field error as well, else it won't be triggered
                //since the 2 fields are the same (empty)
                message += "The password field is empty!\n"
            }
        }
        if password2Field.getTextValue() != password1Field.getTextValue(){
            password2Field.setErrorBorder()
            message += "The passwords do not match!\n"
        }
        if message.count > 0{
            //BUG: Image appears way too big and pixelated
            //let image = UIImage(named: "astronaut.png")
            let popup = PopupDialog(title: "Houston! We have a problem!", message: message)
            self.present(popup, animated: true, completion: nil)
        }

    }
    
    @objc func signup(){
        signupValidation()
        //TODO
        let data : SignUserData = SignUserData(username: usernameField.getTextValue(), email: emailField.getTextValue(), password: password1Field.getTextValue(), gender: Int(genderSlider.value))
        //call model function for saving data
        do{
           try IO.saveUserData(data: data)
            let popup = PopupDialog(title: "Hurray!", message: "You correctly registered!")
            self.present(popup, animated: true, completion: nil)
            
        }catch IOError.encoding{
            let popup = PopupDialog(title: "Houston! We have a problem!", message: "We could not save your data!")
            self.present(popup, animated: true, completion: nil)
        }
        catch{
            let popup = PopupDialog(title: "Houston! We have a problem!", message: "A misterious error has occured, our wizards are on it!")
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    @objc func sliderMoved(){
        if genderSlider.value > 66{
            genderSlider.thumbTintColor = UIColor.app.male
            genderLabel.text = "Gender: Bloke"
            usernameField.setImage(name: "usermale.png")
        }
        else if genderSlider.value > 33 {
            genderSlider.thumbTintColor = UIColor.app.unknown
            genderLabel.text = "Gender: Dychotomies are boring"
            usernameField.setImage(name: "userunknown.png")

        }
        else {
            genderSlider.thumbTintColor = UIColor.app.female
            genderLabel.text = "Gender: Gal"
            usernameField.setImage(name: "userfemale.png")
        }
    }
    
}
