//
//  MainCVC.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/4/22.
//

import UIKit
import SDWebImage

protocol MainCVCDelegate {
    func setStar(index: IndexPath)
}

class MainCVC: UICollectionViewCell {


    static let identifier = "MainCVC"
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var delegate: MainCVCDelegate?
    
    @IBOutlet weak var starBtn: UIButton!
    
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var index: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func update(data: FoodIteamsDM, index: IndexPath) {
        foodName.text = data.name
        imageView.sd_setImage(with: URL(string: data.img ?? ""), placeholderImage: UIImage(systemName: "person.fill"))
        starBtn.setImage(UIImage(systemName: data.isLike ? "star.fill" : "star" ), for: .normal)
        self.index = index
    }

    @IBAction func starBtn(_ sender: Any) {
        delegate?.setStar(index: index)
    }
    
}
