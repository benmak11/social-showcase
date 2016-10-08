//
//  PostCell.swift
//  social-showcase
//
//  Created by Baynham Makusha on 10/8/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
}
