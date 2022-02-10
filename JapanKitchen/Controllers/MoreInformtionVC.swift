//
//  MoreInformtionVC.swift
//  JapanKitchen
//
//  Created by Kuziboev Siddikjon on 2/7/22.
//

import UIKit

class MoreInformtionVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = FoodIteamsDM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        title = data.name
        let btn = UIBarButtonItem(image: UIImage(named: "share"), style: .done, target: self, action: #selector(shareBtnPressed))
        navigationItem.rightBarButtonItem = btn
        
    }
    
    func inviteFriends(){
        
        
        let vc = UIActivityViewController(activityItems: [data.name ?? "" , data.url ?? ""], applicationActivities: nil)
            vc.popoverPresentationController?.sourceView = self.view
            self.present(vc, animated: true, completion: nil)
    }
    
    @objc func shareBtnPressed() {
        print("share")
        inviteFriends()
    }
    
}

//MARK: UITableView
extension MoreInformtionVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TopTVC.nib(), forCellReuseIdentifier: TopTVC.identifier)
        
        tableView.register(IngredientsTVC.nib(), forCellReuseIdentifier: IngredientsTVC.identifier)
        tableView.register(StepTVC.nib(), forCellReuseIdentifier: StepTVC.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 218
        tableView.sectionHeaderTopPadding = 0
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return data.ingredients.count
        case 2: return data.steps.count
        default:
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TopTVC.identifier, for: indexPath)as? TopTVC {
                cell.updateTopCell(img: data.img ?? nil, desc: data.desc ?? "")
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTVC.identifier, for: indexPath)as? IngredientsTVC {
                cell.lblDesc.text = data.ingredients[indexPath.row].name
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: StepTVC.identifier, for: indexPath)as? StepTVC {
                cell.updateCell(steps: data.steps[indexPath.row], indexPath: indexPath)
                return cell
            }
        default:
            print("rowcount")
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        v.backgroundColor = #colorLiteral(red: 0.9366166592, green: 0.4360406101, blue: 0.7025049329, alpha: 1)
        
        
        //Label
        let courseType = UILabel(frame: CGRect(x: 0, y: 14, width: tableView.frame.width, height: 25))
        courseType.translatesAutoresizingMaskIntoConstraints = false
        if section == 1 {
            courseType.text = "Ingredients"
        }else if section == 2 {
            courseType.text = "Steps"
            
        }
        courseType.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        courseType.textAlignment = .left
        courseType.textColor = .white
        v.addSubview(courseType)
        courseType.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 10).isActive = true
        courseType.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 35
        }
    }
}
