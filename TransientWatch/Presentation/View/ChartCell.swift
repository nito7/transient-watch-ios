//
//  ChartCell.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/12.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class ChartCell: UITableViewCell {
    
    // MARK: - Property
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
