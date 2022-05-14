//
//  Message.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 10.05.2022.
//

import SwiftUI

struct Message : Identifiable,Equatable {
    
    var id  = UUID().uuidString
    var message : String
    var myMessage : Bool
}
