//
//  DFTherapyTVCell.swift
//  ICMA
//
//  Created by Dharmani Apps on 06/10/21.
//

import UIKit

class DFTherapyTVCell: UITableViewCell {

    @IBOutlet weak var lblDetails: ICMediumLabel!
    @IBOutlet weak var lblTime: ICRegularLabel!
    @IBOutlet weak var lblView: UIView!
    @IBOutlet weak var mainImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
