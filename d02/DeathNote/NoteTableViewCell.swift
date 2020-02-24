//
//  NoteTableViewCell.swift
//  DeathNote
//
//  Created by Ivan BOHUN on 2/6/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

	@IBOutlet weak var noteTitle: UILabel!
	@IBOutlet weak var noteDescription: UILabel!
	@IBOutlet weak var noteDate: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
