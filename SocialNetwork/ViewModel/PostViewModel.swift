//
//  PostViewModel.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 15/08/22.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var session : Session?
    @Published var content:   String = ""
    @Published var post : Post?

    var heart: Bool = false

    func getNewPost(session: Session?, post: String) async -> (Post?){
        let post = await API().getNewPost(token: session!.token, post: post)

        if let post = post {
            if  post.content != "" {

                DispatchQueue.main.async {
                    self.post = post
                }
                return post
                
            }
        }
        return post
    }

    func getLike(session: Session?){
        API().getLike(id: session!.user.id) { result in
            if (result) != nil {
                print("sucess")
                self.heart = true

            } else {
                print("error")
            }
        }
    }
}
