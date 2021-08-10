//
//  MainStoryCell.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 31/5/21.
//

import UIKit

class MainStoryCell: UITableViewCell {

    var articleImage: UIImageView!
    var title: UILabel!
    var author: UILabel!
    var category: UILabel!
    var pubDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
