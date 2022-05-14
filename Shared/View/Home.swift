//
//  Home.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 10.05.2022.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        
            HStack(spacing: 0){
                VStack{
                    TabButton(image: "gear", title: "Settings", selectedTab: $homeData.selectedTab)
                    
                    TabButton(image: "message", title: "All Chats", selectedTab: $homeData.selectedTab)
                    
                    TabButton(image: "person", title: "Contacts", selectedTab: $homeData.selectedTab)
                    
                    TabButton(image: "mail", title: "Create Chat", selectedTab: $homeData.selectedTab)
                    
                    Spacer()
                    
                }
                .padding()
                .padding(.top, 35)
                .background(Color(red: 38 / 255, green: 28 / 255, blue: 70 / 255))
                
                ZStack{
                    
                    switch homeData.selectedTab{
                    case "Settings": Text("Settings")
                    case "All Chats": NavigationView{AllChatView()}
                    case "Contacts": AddContactView()
                    case "Create Chat": CreateChatView()
                    default: Text("")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: 1200, height: 700)
        .environmentObject(homeData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
