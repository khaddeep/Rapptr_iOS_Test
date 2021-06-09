//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    var loginCLient:LoginClient = LoginClient()
    private var isSuccessful: Bool = false
    private var message: String = ""
    private var apiCallTime: Double = 0
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
   
   
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.setLeftPaddingPoints(24)
        txtPassword.setLeftPaddingPoints(24)
        DispatchQueue.main.async {
                self.txtEmail.becomeFirstResponder()
                self.txtPassword.becomeFirstResponder()
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        // get login details from the view
        if txtEmail.text == "" || txtPassword.text == ""
              {
            Utils.showAlertMessageWithOK(message: "Enter Username and Password", parentView: self)
        }else{
            let methodStart = Date()
            loginCLient.login(withEmail: txtEmail.text, password: txtPassword.text) { [self] (response) in
                let responseCode = response?["code"] as? String
               let responseMessage = response?["message"] as? String
                            if responseCode == "Error" {
                                self.message.append(responseCode ?? "Error Parsing Code")
                                self.isSuccessful=false
                            }else {
                                self.message.append(responseMessage ?? "Error Parsing Message")
                                self.isSuccessful=true
            }
                
                let methodFinish = Date()
                let executionTime = methodFinish.timeIntervalSince(methodStart)
                apiCallTime=executionTime
        }
            if isSuccessful==false {
                Utils.showAlertMessageWithOK(message: message+"\nAPI call in milliseconds: "+String(apiCallTime), parentView: self)
                message=""
            }else{
                Utils.showAlertMessageWithOK(message: message+"\nAPI call in milliseconds: "+String(apiCallTime), parentView: self)
                message=""
            }
        }
        }
    }

