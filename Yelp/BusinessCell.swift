//
//  BusinessCell.swift
//  Yelp
//
//  Created by Wenn Huang on 2/17/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var rateView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    var business: Business! {
        
        didSet{
            titleLabel.text = business.name
            posterView.setImageWith(business.imageURL!)
            categoryLabel.text = business.categories
            addressLabel.text = business.address
            distanceLabel.text = business.distance
            rateView.setImageWith(business.ratingImageURL!)
            reviewLabel.text = "\(business.reviewCount!) Reviews"
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterView.layer.cornerRadius = 3
        posterView.clipsToBounds = true
        
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
