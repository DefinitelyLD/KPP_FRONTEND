//
//  Webservice.swift
//  Messnger_new (iOS)
//
//  Created by Алексей Дробный on 12.05.2022.
//

import Foundation

enum AuthenticationError: Error{
    case invalidCredentials
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


public class WebService{
    
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void){
        
        guard let url = URL("https://localhost:44309/Account/Login") else {
            completion.(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            
            
            guard let data = data, error == nil else{
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponce.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
            
        }.resume()
    }
}
