//
//  Login.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 11/08/22.
//

import SwiftUI

struct InputTextField: View {

    @Binding var textBinding: String

    let label: String
    let placeholder: String
    let secureTextField: Bool

    var body: some View {

        VStack(alignment: .leading){

            Text(label)
                .font(Font.custom("Space Grotesk", size: 18))
                .foregroundColor(.black)

            if secureTextField{

                SecureField(placeholder, text: $textBinding)
                    .textFieldStyle(.plain)
                    .font(Font.custom("Space Grotesk", size: 17))

            } else {

                TextField(placeholder, text: $textBinding)
                    .textFieldStyle(.plain)
                    .font(Font.custom("Space Grotesk", size: 17))

            }
        }
    }
}


struct Login: View {

    @EnvironmentObject var loginVM : LoginViewModel
    @Binding var login : Session?
    @State var isPresented : Bool = false



    var body: some View {

        VStack {

            VStack(alignment: .leading, spacing: 50) {
                Spacer()

                Text("Hello again!!")
                    .font(Font.custom("Space Grotesk", size: 35))
                    .fontWeight(.bold)

                Text("Wellcome back!!")
                    .font(Font.custom("Space Grotesk", size: 30))
                    .bold()

                Spacer()
            }
            .padding(10)

            VStack(alignment: .leading, spacing: 50){
                InputTextField(textBinding: $loginVM.email, label: "Username", placeholder: "example@example.com", secureTextField: false)

                InputTextField(textBinding: $loginVM.password, label: "Password", placeholder: "p@ssW0rd", secureTextField: true)
            }


        VStack(alignment:.center, spacing: 40){

            Spacer()

                Button(action:{
                    Task {
                        login = await loginVM.getLogin()
                    }
                }){
                    HStack{
                        Text("Login")
                            .font(Font.custom("Space Grotesk", size: 17))
                            .foregroundColor(.white)
                            .frame(width: 159, height: 41)
                    }
                }
                .background(Color.black)
                .cornerRadius(15)


            VStack{
                
                Text("Dont have an account?")
                    .font(Font.custom("Space Grotesk", size: 18))
                    .bold()
                
                Button {
                    isPresented = true
                } label: {
                    ZStack(alignment: .center){

                        Text("Sign in here")
                            .underline()
                            .font(Font.custom("Space Grotesk", size: 18))
                            .bold()
                            .foregroundColor(.black)

                    }

                }
                .sheet(isPresented: $isPresented) {
                    SignUp(isPresented: $isPresented)
                }

            }

            Spacer()

            }

        }
        .padding(.vertical, 5)
        .padding(.horizontal, 40)
    }
}


