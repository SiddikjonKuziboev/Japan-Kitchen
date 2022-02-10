//
//  IngredientsTVC.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/8/22.
//

import UIKit

class IngredientsTVC: UITableViewCell {
    
    static let identifier = "IngredientsTVC"
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
