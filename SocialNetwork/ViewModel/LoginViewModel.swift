//
//  LoginViewModel.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 16/08/22.
//

import Foundation

class LoginViewModel: ObservableObject {

    @Published var name: String = ""
    @Published var email:   String = "Nillas@example.com"
    @Published var password:   String = "senha"
    @Published var session: Session?

    @Published var isLoggedIn: Bool = false


    func getLogin() async -> Session? {
        guard email != "", password != "" else { return nil }

        let session = await API.getLogin(email: email, password: password)

        if let session = session {

            DispatchQueue.main.async {
                self.isLoggedIn = true
            }
                return session

            
        } else {
            return nil
        }
    }


    
    func getLogout(session: Session){
        API().getLogout(token: session.token){ result in
            if (result?.token) != nil {
                DispatchQueue.main.async {
                    self.isLoggedIn = false
                }
            } else {
                print("error")
            }
        }
    }


//    func getDeleteAccount(){
//
//        API().getDeleteUser(id: session!.user.id, name: session!.user.name, email: session!.user.email, avatar: session!.user.avatar, completion: { result in
//            return
//
//        })
//    }
}

