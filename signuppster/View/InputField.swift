//
//  InputField.swift
//  signuppster
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 09/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import UIKit
import CoreGraphics

class InputField: UIView, UITextFieldDelegate{
    /*
     This class defines a view with a logo and a text field embedded in it.
     Used for to take inputs in and display
     */
    
    
    let LOGO_WITDH_OFFSET : CGFloat = 2
    let LOGO_HEIGH_OFFSET : CGFloat = 2
    let LOGO_TEXT_OFFSET : CGFloat = 10
    let TEXT_HEIGH_OFFSET : CGFloat = 2
    let TEXT_WIDTH_OFFSET : CGFloat = 2
    
    //style
    let CORNER_RADIUS : CGFloat =  2
    
    
    //Validation
    private var validator : ValidatorType = .initDefault
    private var errorMessage : String?
    private var validated  : Bool = false
    
    
    private var textField : UITextField
    private var imageView : UIImageView
    
    override init(frame: CGRect) {
        self.textField = UITextField()
        self.imageView = UIImageView()
        super.init(frame: frame)
        setSubviewSizes()
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.textField = UITextField()
        self.imageView = UIImageView()
        super.init(coder: aDecoder)
        setSubviewSizes()
        addSubviews()
    }
    
     init(frame:CGRect, imageName:String){
        textField = UITextField()
        imageView = UIImageView()
        super.init(frame: frame)
        setImage(name: imageName)
        setSubviewSizes()
        addSubviews()
    }
    
    func setProperties(imageName:String, placeholder:String, isPassword:Bool, keyboardType:UIKeyboardType, validatorType: ValidatorType){
        validator = validatorType
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        setImage(name: imageName)
        textField.placeholder = placeholder
        if isPassword {
            textField.isSecureTextEntry = true
        }
        textField.keyboardType = keyboardType
        textField.clearButtonMode = .whileEditing
        setSubviewSizes()
        addSubviews()
        setViewStyle()
    }
    
    
   @objc func textFieldDidChange(_ textField: UITextField) {
        validate()
    }
    
    func addSubviews(){
        addSubview(imageView)
        addSubview(textField)
    }
    
    func setImage(name:String){
        let image = UIImage(named: name)
        imageView.image = image
    }

    func setViewStyle(){
        self.layer.cornerRadius = CORNER_RADIUS
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.app.normal.cgColor
        self.backgroundColor = UIColor.white
    }
    
    func setSubviewSizes(){
        imageView.frame.origin.x = LOGO_WITDH_OFFSET;
        imageView.frame.origin.y = LOGO_HEIGH_OFFSET;
        imageView.frame.size.height = self.frame.size.height - 2*LOGO_HEIGH_OFFSET
        imageView.frame.size.width = imageView.frame.size.height
        
        textField.frame.origin.x = imageView.frame.size.width + LOGO_TEXT_OFFSET
        textField.frame.origin.y = TEXT_HEIGH_OFFSET
        textField.frame.size.height = self.frame.size.height - 2*TEXT_HEIGH_OFFSET
        textField.frame.size.width = self.frame.size.width - (imageView.frame.size.width + 2*LOGO_HEIGH_OFFSET + LOGO_TEXT_OFFSET + TEXT_WIDTH_OFFSET)

    }
    
    func validate(){
        ( validated,  errorMessage) = textField.validatedText(validationType: validator)
        if(!validated){
            setErrorBorder()
        }
        else{
            setValidatedBorder()
        }
    }
    
    func isValidated() -> Bool{
        return validated
    }
    
    func getValidationMessage() -> String? {
        return errorMessage
    }
    
    func getTextValue() -> String?{
        return textField.text
    }
    
    func setErrorBorder(){
        self.layer.borderColor = UIColor.app.error.cgColor
    }
    private func setValidatedBorder(){
        self.layer.borderColor = UIColor.app.validated.cgColor
    }
    
    private func resetStyle(){
        self.layer.borderColor = UIColor.app.normal.cgColor
    }
    
}
