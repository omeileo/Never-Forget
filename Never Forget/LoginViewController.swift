//
//  LoginViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/20/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LoginViewController: UIViewController
{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let registerViewSegueIdentifier = "showRegisterViewController"
    let addMissingChildViewDegueIdentifier = "showAddMissingChildViewController"
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.hideKeyboardWhenTappedOutside()
        self.subscribeToKeyboardNotifications()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let retrievedEmail = KeychainWrapper.standard.string(forKey: "neverForgetUserEmail"), let retrievedPassword = KeychainWrapper.standard.string(forKey: "neverForgetUserPassword")
        {
            emailTextField.text = retrievedEmail
            passwordTextField.text = retrievedPassword
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.unsubcribeFromKeyboardNotifcations()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func keyboardWillShow(_ notification: Notification)
    {
        resetView()
        
        view.frame.origin.y -= (getKeyboardHeight(notification)/3)
    }
    
    @IBAction func loginUser(_ sender: UIButton)
    {
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            Auth.auth().signIn(withEmail: email, password: password)
            {
                (user, error) in
                    if error == nil
                    {
                        //_ = self.navigationController?.popViewController(animated: true)
                        let savedEmailToKeychain: Bool = KeychainWrapper.standard.set(email, forKey: "neverForgetUserEmail")
                        let savedPasswordToKeychain: Bool = KeychainWrapper.standard.set(password, forKey: "neverForgetUserPassword")
                        print("\(savedEmailToKeychain) & \(savedPasswordToKeychain)")
                        self.performSegue(withIdentifier: self.addMissingChildViewDegueIdentifier, sender: self)
                    }
                    else
                    {
                        self.showAlert(title: "Error", message: "Insufficient or invalid information.")
                    }
            }
        }
    }
    
    @IBAction func registerUser(_ sender: UIButton)
    {
        performSegue(withIdentifier: registerViewSegueIdentifier, sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
