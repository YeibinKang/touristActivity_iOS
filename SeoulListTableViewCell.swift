//
//  SeoulListTableViewCell.swift
//  A4
//
//  Created by Yeibin Kang on 2021-11-30.
//

import UIKit

class SeoulListTableViewCell: UITableViewCell {

    @IBOutlet weak var actTitle: UILabel!
    
    @IBOutlet weak var actRate: UILabel!
    
    @IBOutlet weak var actPrice: UILabel!
    
    @IBOutlet weak var actDetails: UILabel!
    @IBOutlet weak var actImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
