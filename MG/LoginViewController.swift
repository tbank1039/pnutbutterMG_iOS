//
//  LoginViewController.swift
//  MG
//
//  Created by Tyler Bank on 7/3/17.
//  Copyright © 2017 Tyler Bank. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBAction func submitLoginInfo(_ sender: Any) {
        self.attemptLogin()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailField.delegate = self
        passwordField.delegate = self
        emailField.text = "parkermur@gmail.com"
        passwordField.text = "test1234"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func addAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func attemptLogin() {
        self.submitButton.isEnabled = false
        self.activitySpinner.startAnimating()
        AuthService.login(email: emailField.text!, password: passwordField.text!, completionHandler: { response in
            self.submitButton.isEnabled = true
            self.activitySpinner.stopAnimating()
            switch response {
            case .SUCCESS:
                self.performSegue(withIdentifier: "LoginToHomeSegue", sender: self)
            case .INVALID_CREDENTIALS:
                self.addAlert(title: "Invalid username or password", message: "Please enter a valid username and password.")
            case .UNAUTHORIZED:
                self.addAlert(title: "Unauthorized", message: "Your account is not authorized.")
            case .UNKNOWN_ERROR:
                self.addAlert(title: "Error", message: "Whoops something went wrong!")
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailField { // Switch focus to other text field
            passwordField.becomeFirstResponder()
        }
        
        if (textField.returnKeyType == UIReturnKeyType.go)
        {
            self.attemptLogin()
        }
        return true
    }
}
