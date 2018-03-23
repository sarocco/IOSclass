//
//  ViewController.swift
//  signin
//
//  Created by SP28 on 21/3/18.
//  Copyright © 2018 SP28. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var calendar: UIDatePicker!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Age of 18.
    let MINIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!;
    
    // Age of 100.
    let MAXIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -100, to: Date())!;
    
    @IBAction func signInAction(_ sender: Any) {
        let name = nameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        if let name = name, let email = email, let password = password, let confirmPassword = confirmPassword, let calendar = calendar?.date {
            doLogin(name:name, email:email, password:password, confirmPassword: confirmPassword, calendar: calendar)
        }
    }
    
    @IBAction func mySwitchAction(_ sender: Any) {
        if(mySwitch.isOn){
            signInButton.isEnabled = true
            signInButton.setTitleColor(UIColor.white, for: .normal)
        }else{
            signInButton.isEnabled = false
            signInButton.setTitleColor(UIColor.gray, for: .normal)
        }
    }

    
    func doLogin (name:String, email:String, password:String, confirmPassword:String, calendar: Date) {
        if (isValidEmail(email: email) && name != ""){
            if (password == confirmPassword && password != ""){
                if(validateAge(birthDate: calendar)){
                    
                    self.activityIndicator.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.activityIndicator.stopAnimating()
               
                let alert = UIAlertController(title: "Welcome", message: " ", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                    })
                }else{
                    let alert = UIAlertController(title: "You are under 18", message: "You cannot enter to this app", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
            }else{
            let alert = UIAlertController(title: "Password dismatch", message: "Please verify that both passwords are equals ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            }
        }else{
            let alert = UIAlertController(title: "Invalid Username or Email", message: "Please verify your email or username", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: email)
    }
    
    func validateAge(birthDate: Date) -> Bool {
        var isValid: Bool = true;
        
        if birthDate < MAXIMUM_AGE || birthDate > MINIMUM_AGE {
            isValid = false;
        }
        
        return isValid;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



