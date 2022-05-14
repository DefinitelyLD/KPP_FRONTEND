//
//  JoinChatViewModel.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 14.05.2022.
//

import SwiftUI

class AddToChatViewModel: ObservableObject {

    @Published var chatID: String = ""
    @Published var userName: String = ""
    
    let defaults = UserDefaults.standard
    
    func addToChatroom(){

        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }

        LoginWebService().findUser(token: token, userName: userName){ result in
            switch result{
            case .success(let chatID):
                print("Decoded")
            case .failure(let response):
                print("Can't decode")
            }
        }
    }
}
