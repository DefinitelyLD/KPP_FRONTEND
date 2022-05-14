//
//  AllChatView.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 10.05.2022.
//

import SwiftUI

struct AllChatView: View {
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        VStack{
            
            HStack{
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                })
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $homeData.search)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.primary.opacity(0.15))
            
            .cornerRadius(10)
            .padding()
            
            List(selection: $homeData.selectedrecentMsg){
                ForEach(homeData.msgs){message in
                    NavigationLink(
                        destination:
                            DetailView(user: message),
                        label:{
                            RecentCardView(recentMsg: message)
                        })
                    
                }
            }
            .listStyle(SidebarListStyle())
        }
        .background(Color(red: 38 / 255, green: 28 / 255, blue: 70 / 255))
    }
}

struct AllChatView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
