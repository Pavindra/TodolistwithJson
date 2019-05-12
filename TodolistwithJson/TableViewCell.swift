//
//  TableViewCell.swift
//  TodolistwithJson
//
//  Created by Pavindra Weththasinghe on 5/5/19.
//  Copyright © 2019 Pavindra Weththasinghe. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //@IBOutlet weak var lableTask: UILabel!
    @IBOutlet weak var lableTask: UILabel!
    //@IBOutlet weak var lableImp: UILabel!
    @IBOutlet weak var lableImp: UILabel!
    //@IBOutlet weak var lableCat: UILabel!
    @IBOutlet weak var lableCat: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
