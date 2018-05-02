//
//  labelTableViewCell.swift
//  SearchBarDemo
//
//  Created by Admin on 28/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class labelTableViewCell: UITableViewCell {

    @IBOutlet weak var lblheight: NSLayoutConstraint!
    @IBOutlet weak var lblCity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
