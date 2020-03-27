//
//  SurveysTableViewCell.swift
//  Croesus
//
//  Created by Mitch on 26/03/2020.
//  Copyright © 2020 Mitch. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SurveysTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
