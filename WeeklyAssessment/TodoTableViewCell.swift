//
//  TodoTableViewCell.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/20/25.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var priorityColor: UIView!
    @IBOutlet weak var todoText: UILabel!
    @IBOutlet weak var priority: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        priorityColor.layer.cornerRadius = priorityColor.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
}
