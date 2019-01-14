//
//  PopularPersonTableViewCell.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/13/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import UIKit
import NewBaseFrameWork

class PopularPersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var knowFor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personImageView.circleImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
        bind the views with person data
     */
    func setupViewWithPersonData(person: Results){
        self.personImageView.loadImageUrl(imageUrl: "https://image.tmdb.org/t/p/w500/\(person.profile_path ?? "")", placeholder: #imageLiteral(resourceName: "userAvatar"))
        self.personNameLabel.text = person.name ?? ""
        self.knowFor.text = (person.known_for?.count ?? 0) > 0 ? (person.known_for?[0].media_type ?? "") : ""
    }

}
