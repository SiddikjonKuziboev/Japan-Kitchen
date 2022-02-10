//
//  TopTVC.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/8/22.
//

import UIKit

class TopTVC: UITableViewCell {

    static let identifier = "TopTVC"
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateTopCell(img: String?, desc: String) {
        
        if let img = img {
            foodImage.sd_setImage(with: URL(string: img ), placeholderImage: UIImage(systemName: "person.fill"))
        }
       
        lblDesc.text = desc
    }
    
}
