//
//  Realm.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/7/22.
//
import Foundation
import RealmSwift


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
