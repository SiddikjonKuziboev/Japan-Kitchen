//
//  MainVC.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/4/22.
//

import UIKit
import RealmSwift



class MainVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodData: [FoodIteamsDM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        self.navigationItem.title = "Resipe"
        getData()
        setUpNavigationBarBtn()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(menuBtnPressed))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
}

extension MainVC {
    
    func getData() {
        foodData = RealmData.shared.fetchData()
        if foodData == [] {
           
            let sampleRecordObj = FoodsDM.foods()
                for i in sampleRecordObj {
                
                    //Ingredients
                    let ingred: List<IngredientsDM> = List<IngredientsDM>()
                    for j in i.ingredients {
                        let ing = IngredientsDM()
                        ing.name = j.name
                        ingred.append(ing)
                    }
                    
                    //Steps
                    let steps: List<StepsDM> = List<StepsDM>()
                    for j in i.steps {
                        let step = StepsDM()
                        step.name = j.name
                        step.img = j.img
                        steps.append(step)
                    }
                    
                    let foodIteam = FoodIteamsDM()
                    foodIteam.name = i.name
                    foodIteam.desc = i.desc
                    foodIteam.img = i.img
                    foodIteam.ingredients = ingred
                    foodIteam.steps = steps
                    foodIteam.url = i.url
                    foodIteam.img_url = i.img_url
                    RealmData.shared.saveIteams(data: foodIteam)
                }
            
            self.foodData = RealmData.shared.fetchData()
        }
        collectionView.reloadData()
    }
}

//MARK: UICollectionView
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        cell.delegate = self
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

//MARK: CVC delegate
extension MainVC: MainCVCDelegate {
    
    func setStar(index: IndexPath) {
        RealmData.shared.setLike(name: foodData[index.row].name ?? "")
        collectionView.reloadItems(at: [index])
    }
}


//MARK: Navigation
extension MainVC {
    
    func setUpNavigationBarBtn() {
        //Left Iteam
        let leftIteam = UIBarButtonItem(image: UIImage(named: "fi_menu"), style: .done, target: self, action: #selector(menuBtnPressed))
        leftIteam.tintColor = .white
        navigationItem.leftBarButtonItem = leftIteam
    }
    
        @objc func menuBtnPressed() {
            
            let vc = SideBarVC(nibName: "SideBarVC", bundle: nil)
            let navigation = UINavigationController(rootViewController: vc)
    
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = AppColors.navigation_backround_color
            appearance.titleTextAttributes = [.font:
            UIFont.boldSystemFont(ofSize: 20.0), .foregroundColor: UIColor.white]
            
            
            navigation.navigationBar.standardAppearance = appearance
            navigation.navigationBar.scrollEdgeAppearance = appearance
            navigation.navigationBar.tintColor = .white
            navigation.modalPresentationStyle = .overFullScreen
            present(navigation, animated: false, completion: nil)
        }

    
}

