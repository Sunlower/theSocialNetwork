//
//  API.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 09/08/22.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}
//////
class API {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "http://localhost:8080/posts") else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)

            DispatchQueue.main.async{
                completion(posts)
            }
        }
        .resume()
    }

    func getNewPost(token: String, post: String) async -> (Post?){

        guard let url = URL(string:"http://localhost:8080/posts") else {return nil}

        let data = post.data(using: .utf8)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue("text/plain", forHTTPHeaderField: "Content-type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        request.httpBody = data as Data

        let decoder = JSONDecoder()
        let formatter = ISO8601DateFormatter()

        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let date = formatter.date(from: dateString){
                return date
            }

            throw DecodingError.dataCorruptedError(in: container, debugDescription: "")
        })

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let res = response as? HTTPURLResponse else { return nil }
            if (200..<300).contains(res.statusCode) {
                let finalData  = try JSONDecoder().decode(Post.self, from: data)
                print(finalData)
                return finalData
            } else {
                print("🚨 STATUS CODE \(res.statusCode)\n\(String(data: data, encoding: .utf8) ?? "Body is nil")")
            }
        } catch {
            print(error)
        }

        return nil
    }

    static func getLogin(email: String, password: String) async -> Session? {

        let url = URL(string:"http://localhost:8080/users/login")

        let body: String = "\(email):\(password)"
        let encodeBody = body.data(using: String.Encoding.utf8)!
        let base64 = encodeBody.base64EncodedString()
        var request = URLRequest(url: url!)

        request.httpMethod = "POST"

        request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let finalData  = try JSONDecoder().decode(Session.self, from: data)
            print(finalData)
            return finalData
            
        } catch{
            print("error")
        }
        return nil
    }

    func getLogout( token: String, completion: @escaping (Session?) -> ())  {
        let url = URL(string:"http://localhost:8080/users/logout")

        var request = URLRequest(url: url!)

        request.httpMethod = "POST"

        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (data, response, _) in

                guard let data = data else {return}
                guard let finalData = try? JSONDecoder().decode(Session.self, from: data) else { return }
                completion(finalData)

            }.resume()

    }

    func NewUser(name: String, email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void){

        guard let url = URL(string:"http://localhost:8080/users") else {return}

        let body: [String: String] = [ "name": name ,"email": email, "password": password]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        URLSession.shared.dataTask(with: request) { (data, response, _) in

            guard let data = data else { return }

            do {
                let session = try JSONDecoder().decode(Session.self, from: data)
                completion(.success(session.user.name))
            } catch {
                completion(.failure(.custom(errorMessage: error.localizedDescription)))
            }

        }.resume()
    }


    func getLike(id: UUID, completion: @escaping (Post?) -> Void){
        guard let url = URL(string:"http://localhost:8080/likes") else {return}

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue("text/plain", forHTTPHeaderField: "Content-type")

        request.httpBody = try! JSONEncoder().encode(id)



        URLSession.shared.dataTask(with: request) { (data, response, _) in

            guard let data = data else {return}

            guard let finalData = try? JSONDecoder().decode(Post.self, from: data) else {return}

            completion(finalData)

        }.resume()
    }
}
