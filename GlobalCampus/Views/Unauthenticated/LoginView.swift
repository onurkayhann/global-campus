import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        ZStack {
            Color("ButtonColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Image("global-campus-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text("Login").font(.largeTitle).bold().foregroundStyle(Color("SecondaryColor"))
                
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
                    
                    Button("Login") {
                        db.loginUser(email: email, password: password)
                    }
                    .bold()
                    .padding()
                    .padding(.horizontal, 25)
                    .padding(.vertical, 5)
                    .foregroundStyle(Color("SecondaryColor"))
                    .background(Color("PrimaryColor"))
                    .clipShape(Capsule())
                    .padding()
                    
                    NavigationLink(destination: RegisterView(), label: {
                        Text("Don't have an account? Register")
                            .foregroundStyle(Color("SecondaryColor"))
                            .bold()
                            .padding()
                            .underline()
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    LoginView().environmentObject(DbConnection())
}
