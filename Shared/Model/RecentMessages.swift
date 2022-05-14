//
//  RecentMessages.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 10.05.2022.
//

import SwiftUI

struct RecentMessage : Identifiable {
    
    var id = UUID().uuidString
    var chatID: String
    var lastMsg : String
    var userName : String
    var userImage : String
    var allMsgs: [Message]
}

var recentMsgs : [RecentMessage] = [
    
]

