//
//  View.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 09/08/22.
//

import SwiftUI

struct Home: View{

    @State var posts: [Post] = []
    @State var showingSheet: Bool = false
    
    @Binding var session : Session?
    @Binding var post : Post?

    @EnvironmentObject var postVM : PostViewModel

    let selectDisplayMode : NavigationBarItem.TitleDisplayMode = .large

    var body: some View{
        NavigationView {
            if posts.isEmpty {
                emptyState
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    ForEach(posts, id: \.id) { post in
                        CellHome(post: post, session: $session)
                    }.padding(5)

                    ZStack(alignment: .bottomTrailing){
                        Button {
                            showingSheet = true
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.black)

                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            }
                        }
                        .sheet(isPresented: $showingSheet) {
                            NewPost(showingSheet: $showingSheet, session: $session, post: $post, posts: $posts)
                        }

                    }

                }
                .toolbar {
                    ToolbarItemGroup(placement: .confirmationAction) {

                        ZStack(alignment:.trailing){
                            ZStack{
                                Circle()
                                    .frame(width: 32, height: 32, alignment: .leading)
                                    .foregroundColor(.secondary)
                                    .opacity(0.2)

                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 17, height: 17, alignment: .leading)
                                    .foregroundColor(.black)
                                NavigationLink("", destination: Profile( session: $session))
                            }
                        }.padding(2)
                    }
                }
            }
        }
        .task {
            API().getPosts { post in
                self.posts = post
            }
        }
        .navigationTitle("Home")
        .accentColor(.black)
        .navigationBarTitleDisplayMode(selectDisplayMode)
    }

    var emptyState: some View {
        VStack {
            Text("Wait")
            Text("Loading Posts").font(Font.custom("Space Grotesk", size: 25))
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
                .padding()
        }
    }
}
