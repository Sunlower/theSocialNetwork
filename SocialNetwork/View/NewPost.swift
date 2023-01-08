//
//  NewPost.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 11/08/22.
//

import Foundation
import SwiftUI

struct NewPost: View {

    @EnvironmentObject private var postVM : PostViewModel
    @EnvironmentObject private var loginVM : LoginViewModel

    @Binding var showingSheet: Bool
    @Binding var session: Session?
    @Binding var post: Post?
    @Binding var posts: [Post]
    

    var body: some View{
        NavigationView{
            VStack {
                TextField("Tap here", text: $postVM.content)
                    .padding(50)
                    .font(Font.custom("Space Grotesk", size: 20))
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .cancellationAction) {
                    Button {
                        showingSheet = false
                    } label: {
                        Text("Cancel")
                            .font(Font.custom("Space Grotesk", size: 18))
                            .foregroundColor(.black)
                    }

                }

                ToolbarItemGroup(placement: .principal) {
                   Text("New Post")
                        .font(Font.custom("Space Grotesk", size: 17))
                        .foregroundColor(.black)
                }

                ToolbarItemGroup(placement:.confirmationAction){

                    Button {
                        Task{
                            self.post!.content = postVM.content
                            let post = await postVM.getNewPost(session: session!, post: post!.content)
                            if let post = post {
                                self.posts.insert(post, at: 0)
                            }
                        }
                        showingSheet = false
                    } label: {
                        Text("Send")
                            .font(Font.custom("Space Grotesk", size: 18))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}
