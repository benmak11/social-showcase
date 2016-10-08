//
//  CircleView.swift
//  social-showcase
//
//  Created by Baynham Makusha on 10/8/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
