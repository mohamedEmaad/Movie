
//
//  SomeExtensions.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/14/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView{

        public func loadImageUrl(imageUrl: String, placeholder: UIImage){
            let imgUrl = URL(string: (imageUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!))
            self.sd_setImage(with: imgUrl, placeholderImage: placeholder, options:[ .scaleDownLargeImages, .continueInBackground ])
        }
    
}
