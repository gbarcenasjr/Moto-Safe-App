//
//  SafetyAspectCell.swift
//  Moto-Safe
//
//  Created by Gerardo Barcenas Jr. on 4/16/21.
//

import UIKit

class SafetyAspectCell: UITableViewCell {

    
    @IBOutlet weak var safetyAspectLabel: UILabel!
    @IBOutlet weak var APIResultLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
