//
//  DFHSTherapyVC.swift
//  ICMA
//
//  Created by Dharmani Apps on 06/10/21.
//

import UIKit

class DFHSTherapyVC: UIViewController {
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var tblTherapy: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var TherapyArray = [TherapyData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblTherapy.dataSource = self
        tblTherapy.delegate = self
       
        tblTherapy.register(UINib(nibName: "DFTherapyTVCell", bundle: nil), forCellReuseIdentifier: "DFTherapyTVCell")
        
        self.TherapyArray.append(TherapyData(image: "uncle", details: "Something to Laugh About", time : "1:40"))
        self.TherapyArray.append(TherapyData(image: "uncle", details: "Something to Laugh About", time : "2:40"))
        self.TherapyArray.append(TherapyData(image: "uncle", details: "Something to Laugh About", time : "1:20"))
        self.TherapyArray.append(TherapyData(image: "uncle", details: "Something to Laugh About", time : "3:40"))
    }
    
    
    @IBAction func btnSearch(_ sender: Any) {
    }
    
    @IBAction func btnProfile(_ sender: Any) {
    }
    
    @IBAction func btnNotification(_ sender: Any) {
    }
    
}
extension DFHSTherapyVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DFTherapyTVCell", for: indexPath) as! DFTherapyTVCell
        cell.mainImg.image = UIImage(named: TherapyArray[indexPath.row].image)
        cell.lblDetails.text = TherapyArray[indexPath.row].details
        cell.lblTime.text = TherapyArray[indexPath.row].time
        DispatchQueue.main.async {
            self.heightConstraint.constant = self.tblTherapy.contentSize.height
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TherapyArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

}

struct TherapyData {
    var image : String
    var details : String
    var time : String
    init(image : String, details : String , time : String ) {
        self.image = image
        self.details = details
        self.time = time
     
        
    }
}
