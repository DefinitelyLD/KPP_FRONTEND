//
//  CreateChatView.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 11.05.2022.
//

import SwiftUI

struct CreateChatView: View {
    @EnvironmentObject var homeData : HomeViewModel
    @StateObject private var createChatVM = CreateChatRoomViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            
            Text("Chat Name")
                .fontWeight(.bold)
                .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
            
            TextField("Enter chat name", text: $createChatVM.chatName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.primary)
                .padding(.top, 5)
                .textFieldStyle(PlainTextFieldStyle())
            
            
            Divider()
            
            Button(action: {
                createChatVM.createChatroom()
                DispatchQueue.main.async {
                    homeData.addChat(chatName: createChatVM.chatName)
                    print(createChatVM.chatID)
                }
            }, label: {
                Text("Create Chat")
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
                    .buttonStyle(PlainButtonStyle())
            })
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
        })
        .frame(maxWidth: 400)
        .padding()
    }
}

struct CreateChatView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
