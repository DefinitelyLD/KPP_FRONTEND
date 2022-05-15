//
//  JoinChatViewModel.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 14.05.2022.
//

import SwiftUI

class AddToChatViewModel: ObservableObject {

    @Published var userName: String = ""
    
    let defaults = UserDefaults.standard
    
    func addToChatroom(chatID: String){

        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }

        LoginWebService().findUser(token: token, userName: userName){ result in
            switch result{
            case .success(let addingUserID):
                LoginWebService().addUserToChat(token: token, chatID: chatID, userID: addingUserID) {result in
                    switch result{
                    case .success(let response):
                        print("User added to chat")
                    case.failure(let response):
                        print("User not added")
                    }
                }
            case .failure(let response):
                print("Can't decode")
            }
        }
    }
}
