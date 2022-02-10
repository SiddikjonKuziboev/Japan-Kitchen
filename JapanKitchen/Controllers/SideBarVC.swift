//
//  SideBarVC.swift
//  ComfortOil
//
//  Created by Kuziboev Siddikjon on 2/8/22.
//

import UIKit
import MessageUI

struct SideBarDM {
    var title: String
    var imageName: String
}


class SideBarVC: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dismissBtn: UIButton!
    
    @IBOutlet weak var conView: UIView! {
        didSet {
            conView.layer.cornerRadius = 20
            conView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        }
    }
    
    let sideBarData : [SideBarDM] = [
        SideBarDM(title: "Resipe Japan kitchen", imageName: "food"),
        SideBarDM(title: "Favourites", imageName: "star"),
        SideBarDM(title: "Share", imageName: "share11"),
        SideBarDM(title: "Write to us", imageName: "email"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.288016414)
        conView.transform = .init(translationX: -conView.frame.width, y: 0)
        dismissBtn.alpha = 0
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        UIView.animate(withDuration: 0.3) {
            self.conView.transform = .identity
            self.dismissBtn.alpha = 1
            
        }
        setBackgroundNAvigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func setBackgroundNAvigation(){
        
        //This is for title
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
    }
    
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        dissMissVC()
    }
    
    func dissMissVC() {
        UIView.animate(withDuration: 0.3) {
            self.conView.transform = .init(translationX: -self.conView.frame.width, y: 0)
            self.dismissBtn.alpha = 0
        }completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func inviteFriends(url: String){
        
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            vc.popoverPresentationController?.sourceView = self.view
            self.present(vc, animated: true, completion: nil)
    }
    
   

}

extension SideBarVC: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideBarData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.detailTextLabel?.text = sideBarData[indexPath.row].title
        cell.imageView?.image = UIImage(named: sideBarData[indexPath.row].imageName)

        
        cell.detailTextLabel?.font = UIFont.init(name: "Montserrat-Regular", size: 16)
        cell.detailTextLabel?.textColor = .white
        cell.imageView?.tintColor = AppColors.navigation_backround_color
        cell.backgroundColor = .black
        cell.setSelected(true, animated: true)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: IndexPath(row: indexPath.row, section: indexPath.section), animated: true)
        
        switch indexPath.row {
        case 0:
            dissMissVC()
        case 1:
            let vc = FavouriteVC(nibName: "FavouriteVC", bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            print("set url")
//            inviteFriends(url: )
        case 3:
           showMailComposer()
        default:
            print("next action")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

//MARK: MailComposeView delegate
extension SideBarVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .cancelled:
            break
        case .failed:
            break
        case .saved:
            break
        case .sent:
            break
        @unknown default:
            print("error")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
     func showMailComposer() {
            guard MFMailComposeViewController.canSendMail() else {
                return
            }
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients(["kuziboevsiddiqjon98@gmail.com"])
            composer.setSubject("Hey there!")
//            composer.setMessageBody("Hi, I'd like to know ", isHTML: false)
            present(composer, animated: true)
        }
}
