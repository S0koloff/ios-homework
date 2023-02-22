//
//  LoginView.swift
//  VkSwiftUI
//
//  Created by Sokolov on 22.02.2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var userName = ""
    @State private var password = ""
    @State var user = [String : String]()
    
    @EnvironmentObject var router: TabRouter
    
    var body: some View {
        
        VStack {
            
        VStack {
            Image(systemName: "creditcard.circle.fill")
                .font(.system(size: 100))
                .padding(EdgeInsets(top: -120, leading: 0, bottom: 150, trailing: 0))
        }
        
        VStack(spacing: 1) {
            
            TextField("Username", text: $userName)
                .frame(width: 340, height: 40)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                        )
            
            TextField("Password", text: $password)
                .frame(width: 340, height: 40)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                        )
            
        }
        
            VStack {
                Button {
                    user = [userName : password]
                    router.change(to: .bosses)
                    print(user)
                } label: {
                    Text("Log in")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .bold()
                }
                .frame(width: 350, height: 45)
                .background(.blue)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .cornerRadius(10)
                
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
