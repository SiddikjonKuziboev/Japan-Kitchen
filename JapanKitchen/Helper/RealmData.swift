//
//  Realm.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/7/22.
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



class RealmData {
    
    static var shared = RealmData()
    var realm : Realm!
    
    init() {
        realm = try! Realm()
//        print(realm.configuration.fileURL,"fileurl")
    }
    
    func saveIteams(data: FoodIteamsDM){
        try! realm.write({
            realm.add(data, update: .modified)
        })
    }
    
    func fetchData()-> [FoodIteamsDM] {
        realm.objects(FoodIteamsDM.self).compactMap{$0}
        }
    
    
    
    func deleteAll() {
        try! realm.write({
            realm.deleteAll()
            })
        }
    
    func setLike(name: String) {
        let d = realm.objects(FoodIteamsDM.self).compactMap{$0}
        
        for i in d where i.name == name {
            try! realm.write({
                i.isLike = !i.isLike
            })
        }
        
    }
    
}
