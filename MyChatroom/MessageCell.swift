//
//  MessageCell.swift
//  MyChatroom
//
//  Created by Andy (Liang) Dong on 9/9/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageTextLabel: UILabel!
    
    @IBOutlet weak var messageUserLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageTextLabel.text = ""
        messageUserLabel.text = ""
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
