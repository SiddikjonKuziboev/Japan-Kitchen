//
//  FavouriteVC.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/10/22.
//

import UIKit

class FavouriteVC: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodData: [FoodIteamsDM] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favourites"
        setUpCollectionView()
        fetchData {
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func fetchData(completion: @escaping ()-> Void) {
        let data = RealmData.shared.fetchData()
        
        for i in data where i.isLike {
            foodData.append(i)
        }
        completion()
    }
    
    

}

//MARK: UICollectionView
extension FavouriteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   private func setUpCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCVC.nib(), forCellWithReuseIdentifier: MainCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: MainCVC.identifier, for: indexPath) as? MainCVC else {
            return UICollectionViewCell()
        }
        cell.update(data: foodData[indexPath.row], index: indexPath)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-30)/2, height: (collectionView.frame.height-40)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc  = MoreInformtionVC(nibName: "MoreInformtionVC", bundle: nil)
        vc.data = foodData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
   
}
