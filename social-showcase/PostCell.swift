//
//  PostCell.swift
//  social-showcase
//
//  Created by Baynham Makusha on 10/8/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likeLbl: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(post: Post, img: UIImage? = nil){
        self.post = post
        self.caption.text = post.caption
        self.likeLbl.text = "\(post.likes)"
        
        if img != nil {
            self.postImage.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.imageURL)
            print("BEN: Checkpoint= \(ref)")
            
            ref.data(withMaxSize: (2 * 1024 + 1024), completion: { (data, error) in
                if error != nil {
                    print("BEN: Unable to download image form Firebase storage")
                } else {
                    print("BEN: Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageURL as NSString)
                        }
                    }
                }

            })
        }
    }

    
}
