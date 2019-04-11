//
//  UI_CONSTANTS.swift
//  signuppster
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 09/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import CoreGraphics
import UIKit

let TOP_OFFSET_PERCENTAGE : CGFloat = 0.1
let INPUT_FIELD_HEIGHT_PERCENTAGE : CGFloat = 0.05
let INPUT_FIELD_WIDTH_PERCENTAGE  : CGFloat = 0.9

let LEFT_BORDER : CGFloat = 10

let HEADER_IMAGE_WIDTH_PERCENTAGE : CGFloat = 0.2
let HEADER_INPUT_OFFSET_Y_PERCENTAGE : CGFloat = 0.05
let INPUT_INPUT_OFFSET_Y_PERCENTAGE  : CGFloat = 0.07
let BUTTON_BUTTON_OFFSET_Y_PERCENTAGE : CGFloat = 0.07




//adding a few colors used around in the app under the struct "app"
extension UIColor {
    struct app{
        static let error =      UIColor(red:255/255, green:0/255, blue:0/255, alpha: 1)
        static let normal =     UIColor(red:63/255, green:125/255, blue:176/255, alpha: 1)
        static let validated =  UIColor(red: 0,     green:157/255, blue:255/255,   alpha: 1)
        static let male =       UIColor(red: 0.827, green:0.392, blue:0.306, alpha: 1)
        static let female =     UIColor(red: 0.271, green:0.553, blue:0.553, alpha: 1)
        static let unknown =    UIColor(red: 0.741, green:0.680, blue:0.598, alpha: 1)
    }
}



