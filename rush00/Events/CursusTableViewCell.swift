//
//  CursusTableViewCell.swift
//  42Events
//
//  Created by Denis ROMANICHENKO on 2/9/20.
//  Copyright © 2020 Denis ROMANICHENKO. All rights reserved.
//

import UIKit

class CursusTableViewCell: UITableViewCell {

    @IBOutlet weak var cursusLabel: UILabel!
    @IBOutlet weak var cursusBar: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
