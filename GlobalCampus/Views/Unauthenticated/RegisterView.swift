import SwiftUI

struct RegisterView: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    
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
                
                Text("Register").font(.largeTitle).bold().foregroundStyle(Color("SecondaryColor"))
                
                VStack {
                    TextField("Name", text: $name)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal, 30)
                    
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
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal, 30)
                    
                    Button("Register") {
                        db.registerUser(name: name, email: email, password: password, confirmPassword: confirmPassword)
                    }
                    .bold()
                    .padding()
                    .padding(.horizontal, 25)
                    .padding(.vertical, 5)
                    .foregroundStyle(Color("SecondaryColor"))
                    .background(Color("PrimaryColor"))
                    .clipShape(.buttonBorder)
                    .padding()
                    
                    NavigationLink(destination: LoginView(), label: {
                        Text("Already have an account? Login")
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
    RegisterView().environmentObject(DbConnection())
}
