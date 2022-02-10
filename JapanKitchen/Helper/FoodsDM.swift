//
//  GetDataFromJson.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/7/22.
//
import UIKit


struct FoodsDM: Codable {
    var name: String
    var url: String
    var ingredients: [Ingredients]
    var steps: [Steps]
    var img: String
    var img_url: String
    var desc: String
}


struct Ingredients: Codable {
    var name: String
}

struct Steps: Codable {
    var name: String
    var img: String?
}


extension FoodsDM {
  static func foods() -> [FoodsDM] {
    guard
      let url = Bundle.main.url(forResource: "turk_cuisine", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else {
        return []
    }
    
    do {
      let decoder = JSONDecoder()
      return try decoder.decode([FoodsDM].self, from: data)
    } catch {
      return []
    }
  }
}

