//
//  ViewController.swift
//  TouchIDKeychainDemo
//
//  Created by Vtsoft2 on 8/21/18.
//  Copyright © 2018 hungtv64. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Hello Hung")
        print("Hello Hung")
    }
    
    @IBAction func didTouchUpInsideRegisterButton(_ sender: Any) {
        saveAccountToKeychain(userName: userNameTextField.text, password: passwordTextField.text) { [weak self] in
            self?.performSegue(withIdentifier: "PushToLogin", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func saveAccountToKeychain(userName: String?, password: String?, finished: (() -> ())?) {
        guard let userName = userName?.trimmingCharacters(in: .whitespaces), !userName.isEmpty else {
            // show error
            return
        }
        guard let password = password?.trimmingCharacters(in: .whitespaces), !password.isEmpty else {
            // show error
            return
        }
        // Lưu username vào UserDefaults
        UserDefaults.standard.set(userName, forKey: "lastAccessedUserName")
        // Khởi tạo Keychain
        let passwordItem = KeychainPasswordItem(
            service: KeychainConfiguration.serviceName,
            account: userName,
            accessGroup: KeychainConfiguration.accessGroup
        )
        do {
            // thực hiện lưu vào keychain
            try passwordItem.savePassword(password)
            // call back là success
            finished?()
        } catch {
            // khi có lỗi
            print("Error saving password")
        }
    }

}

