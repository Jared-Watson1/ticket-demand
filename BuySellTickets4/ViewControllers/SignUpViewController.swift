//
//  SignUpViewController.swift
//  BuySellTickets4
//
//  Created by Jared Watson on 12/19/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class SignUpController: UIViewController {
    
    private let database = Database.database().reference()
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var incorrectAlertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    @IBAction func signUpBtnTapped(_ sender: Any) {
        if email.text?.isEmpty == true {
            print("No email inputted")
            incorrectAlertLabel.text = "No email or password inputted!"
            incorrectAlertLabel.textColor = .red
           
            // add alert here to enter in the field
            return
        }
        if password.text?.isEmpty == true {
            print("no password inputted")
            incorrectAlertLabel.text = "No email or password inputted!"
            incorrectAlertLabel.textColor = .red
            return
        }
        if password.text != confirmPassword.text {
            print("Passwords do not match")
            incorrectAlertLabel.text = "Passwords do not match"
            incorrectAlertLabel.textColor = .red
            return
        }
        if firstName.text?.isEmpty == true || lastName.text?.isEmpty == true {
            print("please fill in all required fields")
            incorrectAlertLabel.text = "Please fill in all required fields."
            incorrectAlertLabel.textColor = .red
            return
        }
        signUp()
    }
    
    
    func signUp() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
            print("Error \(String(describing: error?.localizedDescription))")
            return
        }
  
        // send data to firebase database
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid // creating unique ID for each user
        let data = ["email": self.email.text, "firstName": self.firstName.text, "lastName": self.lastName.text, "balance": 0] as [String : Any]
        
        ref.child("users").child(uid!).setValue(data)
//        onSuccess()
        
        // change storyboards
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainHome")
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
        }
    }
    
    @IBAction func alreadyHaveAnAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LogIn")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}
