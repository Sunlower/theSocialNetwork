//
//  SignInViewModel.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 15/08/22.
//

import Foundation

class SignInViewModel: ObservableObject{
    @Published var name: String = ""
    @Published var email:   String = ""
    @Published var password:   String = ""

    func getNewUser(){
        API().NewUser(name: name, email: email, password: password) { result in
            switch result{
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

