//
//  CellViewTable.swift
//  Firebase Example
//
//  Created by Adolfo Lozano Mendez on 5/04/18.
//  Copyright © 2018 Adolfo Lozano Mendez. All rights reserved.
//

import UIKit

class CellViewTable: UITableViewCell {

    @IBOutlet weak var mUserName: UILabel!
    @IBOutlet weak var mImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
