//
//  TableCell.swift
//  Weather
//
//  Created by JAY PATEL on 5/22/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblHigh: UILabel!
    @IBOutlet weak var lblLow: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
