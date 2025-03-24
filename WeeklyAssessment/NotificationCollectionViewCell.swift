//
//  NotificationCollectionViewCell.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/22/25.
//

import UIKit

protocol NotificationCollectionViewCellDelegate: AnyObject {
    
    func didTapOpenImage(with image: UIImage?)
    func didTapEditCell(_ cell: NotificationCollectionViewCell)
}


class NotificationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var outerView: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var descp: UILabel!
    
    weak var delegate: NotificationCollectionViewCellDelegate?

    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    
        outerView.layer.cornerRadius = 10
        img.layer.cornerRadius = 10
    }
    
    @IBAction func openImageBtn(_ sender: Any) {
        
        delegate?.didTapOpenImage(with: img.image)
    }
    
    @IBAction func eidtCellBtnTapped(_ sender: Any) {
        
        delegate?.didTapEditCell(self)
    }
}
