//
//  AddContactView.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 11.05.2022.
//

import SwiftUI

struct AddContactView: View {
    @State var contactName = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            
            Text("Add Contact")
                .fontWeight(.bold)
                .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
            
            TextField("Enter user name", text: $contactName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.primary)
                .padding(.top, 5)
                .textFieldStyle(PlainTextFieldStyle())
            
            
            Divider()
            
            Button(action: {}, label: {
                Text("Add to Contacts")
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


struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
