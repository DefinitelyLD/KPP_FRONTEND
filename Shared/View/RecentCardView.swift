//
//  RecentCardView.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 10.05.2022.
//

import SwiftUI

struct RecentCardView: View {
    var recentMsg: RecentMessage
    var body: some View {
        HStack{
            Image("p0")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(spacing: 4){
                HStack{
                    VStack(alignment: .leading, spacing: 4, content: {
                        Text(recentMsg.userName)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                            
                        
                        Text(recentMsg.lastMsg)
                            .font(.caption)
                            .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                        
                    })
                    
                    Spacer(minLength: 10)
                }
            }
        }
    }
}

struct RecentCardView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
