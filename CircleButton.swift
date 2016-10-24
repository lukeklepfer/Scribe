//
//  CircleButton.swift
//  Scribe
//
//  Created by Luke Klepfer on 10/24/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
@IBDesignable

class CircleButton: UIButton {

    @IBInspectable var cornerRad: CGFloat = 30.0{ //height and width = 60
        didSet{
            setUpView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        
        setUpView()
       
        
    }
    
    func setUpView(){
        layer.cornerRadius = cornerRad
    }

}
