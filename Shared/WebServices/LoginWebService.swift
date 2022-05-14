//
//  LoginWebService.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 12.05.2022.
//

import Foundation

enum AuthenticationError: Error{
    case invalidCredentials
    case custom(errorMessage: String)
}
enum CustomError: Error{
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable{
    let username: String
    let password: String
}

struct LoginResponce: Codable{
    let id: String?
    let userName: String?
    let password: String?
    let email: String?
    let token: String?
}

public class LoginWebService{
    
    func register(username: String, password: String, email: String, completion: @escaping (Result<LoginResponce, AuthenticationError>) -> Void){
        
        let params = ["userName": username, "email": email, "password": password] as Dictionary<String, String>

        print(params)
        
        var request = URLRequest(url: URL(string: "https://e97d-93-76-55-30.eu.ngrok.io/Account/Register")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            guard let data = data, error == nil else{
                completion(.failure(.invalidCredentials))
                return
            }
                    

            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponce.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(loginResponse))
        })

        task.resume()
        
    }
    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponce, AuthenticationError>) -> Void){
        
        let params = ["userName": username, "password": password] as Dictionary<String, String>

        print(params)
        
        var request = URLRequest(url: URL(string: "https://e97d-93-76-55-30.eu.ngrok.io/Account/Login")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            guard let data = data, error == nil else{
                completion(.failure(.invalidCredentials))
                return
            }
                    
            guard let loginResponse = try? JSONDecoder().decode(LoginResponce.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(loginResponse))
        })

        task.resume()
        
    }
    
    func createChatroom(token: String, chatName: String, userID: String, completion: @escaping(Result<String, CustomError>) -> Void){
        
        let params = ["topic": chatName, "password": "123", "userId": userID]
        
        var request = URLRequest(url: URL(string: "https://e97d-93-76-55-30.eu.ngrok.io/Chatroom/CreateChatroom")!)
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sesion = URLSession.shared
        let task = sesion.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            guard let data = data, error == nil else{
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            let jsonResult = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
            let chatRoomID = jsonResult?["id"] as! Int
            let chatRoomIDString = String(chatRoomID)
            
            print(chatRoomIDString)
            
            completion(.success(chatRoomIDString))
            
        })
        
        task.resume()
    }
    
    func sendMessage(token: String, chatID: String, userID: String, messageText: String, completion: @escaping(Result<String, CustomError>) -> Void){
        
        let params = ["chatID": chatID, "userId": userID, "text": messageText]
        
        var request = URLRequest(url: URL(string: "https://e97d-93-76-55-30.eu.ngrok.io/Message/SendMessage")!)
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sesion = URLSession.shared
        let task = sesion.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            guard let data = data, error == nil else{
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            completion(.success("Successfully sent message"))
        })
        
        task.resume()
    }
    
    
    func findUser(token: String, userName: String, completion: @escaping(Result<String, CustomError>) -> Void){
        
        let params = userName
        
        var request = URLRequest(url: URL(string: "https://e97d-93-76-55-30.eu.ngrok.io/Account/GetUserByUserName")!)
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(params)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sesion = URLSession.shared
        let task = sesion.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            guard let data = data, error == nil else{
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponce.self, from: data) else {
                completion(.failure(.custom(errorMessage: "User not found")))
                return
            }
            
            print("adding user id: " + (loginResponse.id ?? ""))
            completion(.success(loginResponse.id ?? ""))
        })
        
        task.resume()
    }
    func addUserToChat(token: String, chatID: String, userID: String, completion: @escaping(Result<String, CustomError>) -> Void){
        
        let params = userID
        
        var request = URLRequest(url: URL(string: "https://e97d-93-76-55-30.eu.ngrok.io/Chatroom/AddToChatroom?chatId=" + chatID)!)
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(params)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sesion = URLSession.shared
        let task = sesion.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            guard let data = data, error == nil else{
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            completion(.success("Successfully invited user"))
        })
        
        task.resume()
    }
    
}
