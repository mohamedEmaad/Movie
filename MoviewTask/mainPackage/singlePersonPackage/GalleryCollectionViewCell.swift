//
//  GalleryCollectionViewCell.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/14/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var galleryImageView: UIImageView!
    
    func setupImageData(imageUrl: String){
        self.galleryImageView.setCornerRaduis(raduis: 3)
        self.galleryImageView.loadImageUrl(imageUrl: imageUrl, placeholder: #imageLiteral(resourceName: "Placeholder%20(1)"))
    }
}
