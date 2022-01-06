//
//  SignInViewController.swift
//  BuySellTickets4
//
//  Created by Jared Watson on 12/19/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        checkUserInfo() // uncomment this to load main screen automatically if user already logged on
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func dontHaveAnAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func validateFields() {
        if email.text?.isEmpty == true {
            print("No email text")  // add alerts here to propmpt user
            return
        }
        if password.text?.isEmpty == true {
            print("no password") // add alerts here to propmpt user
            return
        }
        logIn()
    }
    
    func logIn() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, err in
        guard let strongSelf = self else {return}
        if let err = err {
            print(err.localizedDescription)
        }
        self!.checkUserInfo()
        }
    }
    
    func checkUserInfo() { // auto load user onto main page of app
            if Auth.auth().currentUser != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MainHome")
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true)
            }
        }
    
}
