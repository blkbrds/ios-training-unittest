//
//  LoginViewController.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/5/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func inputInfo(yourName: String, friendName: String) {
        nameTextField.text = yourName
        passWordTextField.text = friendName
    }

    @IBAction func didTapLogin(_ sender: UIButton) {
        viewModel.name = nameTextField.text ?? ""
        viewModel.passWord = passWordTextField.text ?? ""
//        if viewModel.isValidateInfo() {
//            let catVC = HomeViewController()
//            navigationController?.pushViewController(catVC, animated: true)
//        }
        let catVC = CatCollectionViewController()
        navigationController?.pushViewController(catVC, animated: true)
    }
}
