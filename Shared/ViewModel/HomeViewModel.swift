//
//  HomeViewModel.swift
//  Messnger_new (iOS)
//
//  Created by Алексей Дробный on 10.05.2022.
//

import SwiftUI

class HomeViewModel : ObservableObject{
    
    @Published var selectedTab = "All Chats"
    
    @Published var msgs : [RecentMessage] = recentMsgs
    
    @Published var selectedrecentMsg : String? = recentMsgs.first?.id
    
    @Published var search = ""
    
    @Published var message = ""
    
    @Published var isExpanded = false
    
    @Published var isMuted = false
    
    @Published var showLogin = true
    
    @Published var chatID = ""
    
    func sendMessage(user: RecentMessage){
        
        print(chatID)
        
        if message != ""{

            let index = msgs.firstIndex{(currentUser) -> Bool in
                return currentUser.id == user.id
            } ?? -1
            
            if index != -1{msgs[index].allMsgs.append(Message(message: message, myMessage: true))}
        }
    }
    
    func addChat(chatName: String){
        let defaults = UserDefaults.standard
        chatID = defaults.string(forKey: "ChatID") ?? "1"
        if(chatID != "1"){
            chatID = String((Int(chatID) ?? 0) + 1)
        }
        print(chatID)
        
        msgs.append(RecentMessage(chatID: chatID, lastMsg: "Chat" + chatID, userName: chatName, userImage: "p0", allMsgs: []))
    }
    
    func test(){
        print("test")
    }
}
