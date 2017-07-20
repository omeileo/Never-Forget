//
//  LoginViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/20/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController
{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let registerViewSegueIdentifier = "showRegisterViewController"
    let addMissingChildViewDegueIdentifier = "showAddMissingChildViewController"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
