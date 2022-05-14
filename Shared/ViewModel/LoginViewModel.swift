//
//  LoginViewModel.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 12.05.2022.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    let defaults = UserDefaults.standard
    
    func login(){
        LoginWebService().login(username: username, password: password){ result in
            switch result {
            case .success(let loginResponse):
                self.defaults.setValue(loginResponse.token, forKey: "jsonwebtoken")
                self.defaults.setValue(loginResponse.id, forKey: "userID")
                print(loginResponse.id)
                print(loginResponse.token)
                DispatchQueue.main.async {
                    if(loginResponse.id != nil){
                        self.isAuthenticated = true
                    }
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

