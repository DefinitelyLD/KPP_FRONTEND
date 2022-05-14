//
//  DetailView.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 11.05.2022.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var homeData : HomeViewModel
    @StateObject private var sendMessageVM = SendMessageViewModel()
    
    var user: RecentMessage
    var body: some View {

        HStack {
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Text(user.userName)
                        .font(.title2)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {withAnimation{homeData.isExpanded.toggle()}}, label: {
                        
                        Image(systemName: "sidebar.right")
                            .font(.title2)
                            .foregroundColor(homeData.isExpanded ? .blue : .primary)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                
                // Message View....
                
                MessageView(user : user)
                
                HStack(spacing: 15){
               
                    TextField("Enter Message", text: $homeData.message, onCommit: {
                        homeData.sendMessage(user: user)
                        print("messge: " + homeData.message)
                        sendMessageVM.sendMessage(chatID: homeData.chatID, messageText: homeData.message)
                        homeData.message = ""
                    })
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.vertical,8)
                        .padding(.horizontal)
                        .clipShape(Capsule())
                        .background(Capsule().strokeBorder(Color.primary))
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "paperplane")
                            .font(.title2)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "paperclip")
                            .font(.title2)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .padding([.horizontal,.bottom])
            }
            
            ExpandedView(user: user)
                .background(Color(red: 38 / 255, green: 28 / 255, blue: 70 / 255))
                .frame(width: homeData.isExpanded ? nil : 0)
                .opacity(homeData.isExpanded ? 1 : 0)
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct MessageView : View{
    @EnvironmentObject var homeData : HomeViewModel
    var user: RecentMessage
    
    var body: some View{
        GeometryReader{ reader in
            ScrollView{
                
                ScrollViewReader{proxy in
                    
                    VStack(spacing: 18){
                        ForEach(user.allMsgs){message in
                            
                            MessageCardView(message: message, user: user, width: reader.frame(in: .global).width)
                                .tag(message.id)
                            
                        }
                        .onAppear(perform: {
                            let lastID = user.allMsgs.last!.id
                            
                            proxy.scrollTo(lastID, anchor: .bottom)
                        })
                        .onChange(of: user.allMsgs, perform: {
                            value in
                            
                            let lastID = user.allMsgs.count == 0 ? "0" : user.allMsgs.last!.id
                            
                            proxy.scrollTo(lastID, anchor: .bottom)
                        })
                        .padding(.bottom, 10)
                    }
                }
            }
        }
    }
}

struct MessageCardView: View{
    var message: Message
    var user: RecentMessage
    var width: CGFloat
    
    var body: some View{
        HStack(spacing: 10){
            if message.myMessage{
                Spacer()
                
                Text(message.message)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color(red: 68 / 255, green: 51 / 255, blue: 123 / 255))
                    .cornerRadius(10)
                    .frame(minWidth: 0, maxWidth: width/2, alignment: .trailing)
                
            }
            else{
                Image("p0")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .offset(y: 20)
                    .padding(10)
                
                Text(message.message)
                    .foregroundColor(Color.primary)
                    .padding(10)
                    .background(Color.primary.opacity(0.2))
                    .clipShape(MessageBuble())
                    .frame(minWidth: 0, maxWidth: width/2, alignment: .leading)
                
                Spacer()
            }
        }
    }
}

struct MessageBuble: Shape{
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            let pt1 = CGPoint(x:0, y:0)
            let pt2 = CGPoint(x: rect.width, y:0)
            let pt3 = CGPoint(x: rect.width, y:rect.height)
            let pt4 = CGPoint(x:0, y:rect.height)
            
            path.move(to: pt4)
            
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 15)
            
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 15)

            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 15)

            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 15)

        }
    }
}

struct ExpandedView: View {
    @EnvironmentObject var homeData : HomeViewModel
    @StateObject private var addToChatVM = AddToChatViewModel()
    var user: RecentMessage
    var body: some View{
        
        HStack(spacing : 0){
            Divider()
            
            VStack(spacing: 25){
                Text("Chat Info")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                
                Image("p0")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .padding(.top, 10)
                
                Text(user.userName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                
                HStack
                {
                    Button(action: {homeData.isMuted.toggle()}, label: {
                        
                        VStack{
                            Image(systemName: homeData.isMuted ? "bell.slash" : "bell")
                                .font(.title2)
                            
                            Text(homeData.isMuted ? "Unmute" : "Mute")
                        }
                        .contentShape(Rectangle())
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .foregroundColor(.gray)
                
                HStack{
                    Text("Participants")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 10)
                .padding()
                
                
                VStack{
                    
                    Text("Add to Chat")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    
                    TextField("Enter user name", text: $addToChatVM.userName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.primary)
                        .padding(.top, 5)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    Divider()
                    
                    Button(action: {
                        addToChatVM.addToChatroom()
                        //createChatVM.createChatroom()
                        /*DispatchQueue.main.async {
                            homeData.addChat(chatName: createChatVM.chatName)
                            print(createChatVM.chatID)
                        }*/
                    }, label: {
                        Text("Invite")
                            .fontWeight(.bold)
                            .foregroundColor(Color.primary)
                            .buttonStyle(PlainButtonStyle())
                    })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)
                }
                .padding()
                
                Spacer()
            }
            
        }
            .frame(maxWidth: 300)
        }
    }

