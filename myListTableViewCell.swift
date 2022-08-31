//
//  myListTableViewCell.swift
//  A4
//
//  Created by Yeibin Kang on 2021-12-02.
//

import UIKit

class myListTableViewCell: UITableViewCell {
    
    //MARK: outlets
    

    @IBOutlet weak var myTitle: UILabel!
    
    @IBOutlet weak var myRate: UILabel!
    
    @IBOutlet weak var myPrice: UILabel!
    
    
    @IBOutlet weak var myDetails: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
