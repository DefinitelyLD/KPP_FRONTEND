//
//  RegistrationViewModel.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 13.05.2022.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    
    func register(){
        
        LoginWebService().register(username: username, password: password, email: email){ result in
            switch result{
            case .success(let response):
                print("Decoded")
            case .failure(let response):
                print("Can't decode")
            }
        }
    }
}

