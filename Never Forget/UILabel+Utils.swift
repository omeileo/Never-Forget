//
//  UILabel+Utils.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/7/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import UIKit

class IndentedLabel: UILabel
{
    
    var edgeInsets:UIEdgeInsets = UIEdgeInsets.zero
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect
    {
        let insetRect = UIEdgeInsetsInsetRect(bounds, edgeInsets)
        var textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        textRect.size.width  += 10
        textRect.size.height += 10
        
        return textRect
    }
    
    override func drawText(in rect: CGRect)
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = 3
        super.drawText(in: UIEdgeInsetsInsetRect(rect, edgeInsets))
    }
}
