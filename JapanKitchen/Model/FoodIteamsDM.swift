//
//  FoodIteamsDM.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/10/22.
//

import Foundation
import RealmSwift

class FoodIteamsDM: Object, Codable {
    @objc dynamic var name: String?
    @objc dynamic var url: String?
    var ingredients: List<IngredientsDM> = List<IngredientsDM>()
    var steps: List<StepsDM> = List<StepsDM>()
    @objc dynamic var img: String?
    @objc dynamic var desc: String?
    @objc dynamic var img_url: String?
    @objc dynamic var isLike: Bool = false
    
    override class func primaryKey() -> String? {
        "name"
    }
}

class IngredientsDM: Object, Codable {
    @objc dynamic var name: String?
}

class StepsDM: Object, Codable {
    @objc dynamic var name: String?
    @objc dynamic var img: String?
}


