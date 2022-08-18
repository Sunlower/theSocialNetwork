//
//  Config.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 17/08/22.
//

import SwiftUI

struct Config: View {


    @EnvironmentObject var loginVM : LoginViewModel
    @Binding var session: Session?

    @Binding var isPresent : Bool
    
    var body: some View {

        NavigationView{

            VStack{

                Button {
                    //loginVM.changeAvatar
                } label: {
                    ZStack{
                        Circle()
                            .frame(width: 120, height: 120, alignment: .leading)
                            .foregroundColor(.gray)
                            .opacity(0.2)

                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .leading)
                            .foregroundColor(.black)
                    }
                }

                Spacer()

                InputTextField(textBinding: $loginVM.name , label: "Name", placeholder: "User.name", secureTextField: false)

                InputTextField(textBinding: $loginVM.email, label: "Email", placeholder: "User.email", secureTextField: false)

                Spacer()

                Button {
                    Task{
                        loginVM.getLogout
                    }
                } label: {
                    Text("Logout")
                        .font(Font.custom("Space Grotesk", size: 17))
                        .foregroundColor(.white)
                        .frame(width: 159, height: 41)
                }
                .background(Color.black)
                .cornerRadius(15)
                .padding(20)

                Button(action:{
                    Task {
                        //TODO
                    }
                }){
                    HStack{
                        Text("Delete account")
                            .font(Font.custom("Space Grotesk", size: 14))
                            .foregroundColor(.black)
                            .underline()
                            .frame(width: 159, height: 41)
                    }
                }

                Spacer()
            }

            .padding(.vertical, 20)
            .padding(.horizontal, 40)
            .toolbar {
                ToolbarItemGroup(placement: .cancellationAction) {

                    Button {
                        isPresent = false
                    } label: {
                        Text("Cancel")
                            .font(Font.custom("Space Grotesk", size: 18))
                            .foregroundColor(.black)
                    }

                }

                ToolbarItemGroup(placement: .principal) {

                    Text("Update profile")
                        .font(Font.custom("Space Grotesk", size: 17))
                        .foregroundColor(.black)
                }

                ToolbarItemGroup(placement:.confirmationAction){

                    Button {
                        //loginVM.updateLogin
                    } label: {
                        Text("Update")
                            .font(Font.custom("Space Grotesk", size: 18))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

//struct Config_Previews: PreviewProvider {
//    static var previews: some View {
//        Config()
//    }
//}
