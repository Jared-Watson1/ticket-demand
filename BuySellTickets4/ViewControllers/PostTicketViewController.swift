//
//  PostTicketViewController.swift
//  BuySellTickets4
//
//  Created by Jared Watson on 12/20/21.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostTicketViewController: UIViewController {
   
    let uid = Auth.auth().currentUser?.uid
    var databaseHandle: DatabaseHandle?
    var data = [String]()
    
    @IBOutlet weak var balanceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set the firebase reference
        let ref = Database.database().reference()
        // get information
    }
     
    
    @IBAction func backArrowPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainHome")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}
    
