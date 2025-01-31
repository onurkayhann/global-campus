//
//  RegisterView.swift
//  GlobalCampus
//
//  Created by Onur Kayhan on 2025-01-31.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack {
            
            Image("global-campus-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("Register").font(.largeTitle).bold().foregroundStyle(.black)
            
            VStack {
                TextField("Email address", text: $email)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
            }
            
        }
        
    }
}

#Preview {
    RegisterView()
}
