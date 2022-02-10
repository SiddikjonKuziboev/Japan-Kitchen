//
//  StepTVC.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/10/22.
//

import UIKit

class StepTVC: UITableViewCell {
    
    static let identifier = "StepTVC"
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    @IBOutlet weak var foodImageContainerView: UIView!
    
    @IBOutlet weak var numberContainerView: UIView!{
        didSet {
            numberContainerView.layer.borderColor = #colorLiteral(red: 0.9366166592, green: 0.3422256781, blue: 0.7025049329, alpha: 1)
            numberContainerView.layer.borderWidth = 2
        }
    }
    
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var foodImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(steps: StepsDM, indexPath: IndexPath) {
        
            lblTitle.text = steps.name
            numberLbl.text = "\(indexPath.row + 1)"

            if let img = steps.img {
                foodImage.sd_setImage(with: URL(string: img ), placeholderImage: UIImage(systemName: "person.fill"))
                foodImageContainerView.isHidden = false

            }else {
                foodImageContainerView.isHidden = true
            }
        }
    
}
