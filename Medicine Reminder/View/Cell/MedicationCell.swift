//
//  MedicationCell.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import UIKit

class MedicationCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    var medication: MedicationEntity? = nil {
        didSet {
            guard let data = medication else { return }
            titleLbl.text = data.name
            descLbl.text = "\(data.dose ?? "") - \(data.frequency ?? "")"
            timeLbl.text = data.reminderTime
            iconImage.image = UIImage(named: data.icons ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
