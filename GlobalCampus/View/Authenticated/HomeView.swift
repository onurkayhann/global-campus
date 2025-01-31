//
//  HomeView.swift
//  GlobalCampus
//
//  Created by Onur Kayhan on 2025-01-31.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        Text("Welcome User!")
        
        Button("Logout") {
            db.signOut()
        }
        .bold()
        .padding()
        .padding(.horizontal, 25)
        .padding(.vertical, 5)
        .foregroundStyle(.white)
        .background(.red)
        .clipShape(.buttonBorder)
        .padding()
    }
}

#Preview {
    HomeView().environmentObject(DbConnection())
}
