import SwiftUI

struct UniversityCard: View {
    @EnvironmentObject var db: DbConnection
    
    var university: ApiUniversity
    
    private var isEnrolled: Bool {
        db.currentUserData?.universityApplication.contains(university.id ?? "") ?? false
    }
    
    var body: some View {
        ZStack {
            Color("ButtonColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Text(university.name)
                    .foregroundStyle(Color("SecondaryColor"))
                    .bold()
                
                Text(university.country)
                    .foregroundStyle(Color("SecondaryColor"))
                    .bold()
                
                Spacer()
                
                HStack {
                    Button(action: {
                        guard let universityId = university.id else { return }
                        
                        if isEnrolled {
                            db.deleteUniversityFromApplication(universityId: universityId)
                        } else {
                            db.addUniversityToApplication(universityId: universityId)
                        }
                    }) {
                        Text(isEnrolled ? "Enrolled" : "Enroll")
                    }
                    .padding()
                    .padding(.horizontal, 25)
                    .padding(.vertical, 5)
                    .background(Color("ButtonColor"))
                    .foregroundColor(Color("ThirdColor"))
                    .bold()
                    .clipShape(Capsule())
                    
                    Spacer()
                }
            }
            .padding()
            .frame(width: 325, height: 200, alignment: .leading)
            .background(Color("PrimaryColor"))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("ThirdColor"), lineWidth: 3)
            )
        }
    }
    
}

#Preview {
    UniversityCard(university: ApiUniversity(name: "Stockholms University", country: "Sweden")).environmentObject(DbConnection())
}
