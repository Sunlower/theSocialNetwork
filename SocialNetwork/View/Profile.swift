//
//  Profile.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 11/08/22.
//

import Foundation
import SwiftUI


struct Profile: View {

    @EnvironmentObject var loginVM : LoginViewModel
    @State var isPresented : Bool = false
    @Binding var session : Session?

    var body: some View{
        NavigationView{
            VStack (alignment: .center) {


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

                VStack{
                    Text(session!.user.name)
                        .font(Font.custom("Space Grotesk", size: 20))
                        .foregroundColor(.black)


                    Text(loginVM.email)
                        .font(Font.custom("Space Grotesk", size: 15))
                        .foregroundColor(.secondary)
                }
                .padding(10)

                Spacer()


            }

            .toolbar {
                Button {
                    isPresented = true
                } label: {
                    ZStack{
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .leading)
                            .foregroundColor(.black)
                    }
                }
                .sheet(isPresented: $isPresented) {
                    Config(session: $session, isPresent: $isPresented)
                }
           }
        }
        .accentColor(.accentColor)
    }
}

