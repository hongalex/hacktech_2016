//
//  pingTextField.swift
//  p!ng
//
//  Created by Kyle Tan on 2/27/16.
//  Copyright © 2016 yakk. All rights reserved.
//

import UIKit

class pingTextField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
     override func awakeFromNib()
    {
        super.awakeFromNib();
        
        self.backgroundColor = UIColor.clearColor();
        
        let borderColor : UIColor = UIColor.whiteColor();
        
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = 2.0;
    
    }
    

}
