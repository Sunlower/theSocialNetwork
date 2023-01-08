//
//  CellHome.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 10/08/22.
//

import Foundation
import SwiftUI

struct CellHome: View{

    @State var post: Post
    @State var heart: Bool = false
    @EnvironmentObject var postVM : PostViewModel
    @Binding var session: Session?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(.thinMaterial)
                .frame(width: 300, height: 132)
                .padding(0)

            VStack(alignment: .leading){

                HStack{
                    ZStack{

                        Circle()
                            .frame(width: 32, height: 32, alignment: .leading)
                            .foregroundColor(.white)
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 14, height: 14, alignment: .leading)
                            .foregroundColor(.black)
                    }


                    Text(session!.user.name)
                        .font(Font.custom("Space Grotesk", size: 13))
                        .foregroundColor(.black)
                }

                HStack {
                    Text(post.content)
                        .fontWeight(.regular)
                        .font(Font.custom("Space Grotesk", size: 13))
                        .lineLimit(4)
                        .minimumScaleFactor(0.7)
                        .padding(5)

                    Button {
                        heart.toggle()
                        postVM.getLike(session: session)
                    } label: {
                        Label("", systemImage: heart ? "heart.fill" : "heart")
                            .labelStyle(.iconOnly)
                            .foregroundColor(heart ? .gray : .gray)
                    }
                }

                HStack {
                    Text(post.createdat)
                }
                .font(Font.custom("Space Grotesk", size: 10))
                .foregroundColor(.secondary)
                .padding(5)


            }
            .padding(1)
            .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 50)
        }
    }
    
}
