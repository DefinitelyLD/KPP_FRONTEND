//
//  SignInPage.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 11.05.2022.
//

import SwiftUI

struct PageManager: View {
    
    @State var showLogin = true
    @State var showHomePage = false
    
    var body: some View {
        return Group {
            if showHomePage{
                Home()
            }
            if showLogin && showHomePage == false {
                LoginPage(showLogin: $showLogin, showHomePage: $showHomePage)
            }
            else if showLogin == false && showHomePage == false {
                RegisterPage(showLogin: $showLogin, showHomePage: $showHomePage)
            }
        }
    }
}

struct LoginPage: View {
    @StateObject private var loginVM = LoginViewModel()

    @Binding var showLogin: Bool
    @Binding var showHomePage: Bool

    var body: some View {
        
        VStack{
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                .kerning(1.9)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("User Name")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                
                TextField("Username", text: $loginVM.username)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    .padding(.top, 5)
                    .textFieldStyle(PlainTextFieldStyle())
                
                
                Divider()
                
            })
            .padding(.top, 25)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                
                SecureField("Password", text: $loginVM.password)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    .padding(.top, 5)
                    .textFieldStyle(PlainTextFieldStyle())
                
                
                Divider()
                
            })
            .padding(.top, 25)
            
            Button(action: {}, label: {
                Text("Forgot Password?")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    .buttonStyle(PlainButtonStyle())
            })
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
            
            Button(action: {
                loginVM.login()
                if(loginVM.isAuthenticated){
                    self.showHomePage = true
                }
            }, label: {
                Text("Confirm")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    .buttonStyle(PlainButtonStyle())
                
            })
            .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Text("No account yet?")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    
                    Button(action: {
                        self.showLogin = false
                    }, label: {
                        Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .background(Color(red: 38 / 255, green: 28 / 255, blue: 70 / 255))
                }
        }
        .frame(width: 500, height: 300)
        .padding()
        .background(Color(red: 38 / 255, green: 28 / 255, blue: 70 / 255))
    }
}


struct RegisterPage: View {
    @StateObject private var registrationVM = RegistrationViewModel()
    
    @Binding var showLogin: Bool
    @Binding var showHomePage: Bool
    
    var body: some View {
        
        VStack{
            Text("Sign Up")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                .kerning(1.9)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("User Name")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                
                TextField("Username", text: $registrationVM.username)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    .padding(.top, 5)
                    .textFieldStyle(PlainTextFieldStyle())
                
                
                Divider()
                
            })
            .padding(.top, 25)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("Email")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                
                TextField("Example@gmal.com", text: $registrationVM.email)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    .padding(.top, 5)
                    .textFieldStyle(PlainTextFieldStyle())
                
                
                Divider()
                
            })
            .padding(.top, 25)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                
                SecureField("Password", text: $registrationVM.password)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    .padding(.top, 5)
                    .textFieldStyle(PlainTextFieldStyle())
                
                
                Divider()
                
            })
            .padding(.top, 25)
            
            Button(action: {}, label: {
                Text("Forgot Password?")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    .buttonStyle(PlainButtonStyle())
            })
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
            
            Button(action: {
                registrationVM.register()
                self.showLogin = true
            }, label: {
                Text("Confirm")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    .buttonStyle(PlainButtonStyle())
                
            })
            .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Text("Already Member")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 235 / 255, green: 234 / 255, blue: 253 / 255))
                    
                    Button(action: {
                        self.showLogin = true
                    }, label: {
                        Text("Sign In")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .background(Color(red: 38 / 255, green: 28 / 255, blue: 70 / 255))
                }
        }
        .frame(width: 500, height: 400)
        .padding()
        .background(Color(red: 38 / 255, green: 28 / 255, blue: 70 / 255))
    }
}
