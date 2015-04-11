//
//  HomeCell.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/11.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    // MARK: - Property
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var raLabel: UILabel!
    @IBOutlet weak var decLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var fluxChangeLabel: UILabel!
    
    var astroObj: AstroObj? {
        didSet {
            if let astro = self.astroObj {
                self.nameLabel.text = astro.name
                self.raLabel.text = astro.ra?.description
                self.decLabel.text = astro.dec?.description
                self.classLabel.text = astro.astroClassId?.description
                self.fluxChangeLabel.text = "100%"
            }
        }
    }
    
    // MARK: - LifeCycle
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.textLabel?.textColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
