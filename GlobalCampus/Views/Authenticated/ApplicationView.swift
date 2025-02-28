import SwiftUI

struct ApplicationView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        ZStack {
            Color("ButtonColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Your Application")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color("SecondaryColor"))
                    .padding(.top, 30)
                
                if let appliedUniversities = db.currentUserData?.universityApplication, !appliedUniversities.isEmpty {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(appliedUniversities, id: \.self) { university in
                                HStack {
                                    Text(university)
                                        .font(.headline)
                                        .foregroundStyle(Color("PrimaryColor"))
                                        .padding()
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        db.deleteUniversityFromApplication(universityName: university)
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(Color.red)
                                            .font(.title2)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("SecondaryColor").opacity(0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.vertical, 10)
                    }
                } else {
                    Text("No applications found")
                        .foregroundStyle(Color("PrimaryColor"))
                        .padding()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ApplicationView().environmentObject(DbConnection())
}
