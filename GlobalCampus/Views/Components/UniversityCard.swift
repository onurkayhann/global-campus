import SwiftUI

struct UniversityCard: View {
    @EnvironmentObject var db: DbConnection
    var university: ApiUniversity

    // ✅ Check if the user is enrolled in the university
    private var isEnrolled: Bool {
        db.currentUserData?.universityApplication.contains(university.name) ?? false
    }

    var body: some View {
        ZStack {
            Color("ButtonColor").edgesIgnoringSafeArea(.all)
            
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
                        let universityName = university.name

                        if isEnrolled {
                            db.deleteUniversityFromApplication(universityName: universityName) // ✅ Allow toggle back
                        } else {
                            db.addUniversityToApplication(universityName: universityName)
                        }
                    }) {
                        Text(isEnrolled ? "Enrolled" : "Enroll")
                            .padding()
                            .padding(.horizontal, 25)
                            .padding(.vertical, 5)
                            .background(
                                isEnrolled
                                ? Color("PrimaryColor").opacity(0.7)  // ✅ Darker/muted when enrolled
                                : Color("ButtonColor") // ✅ Normal button color
                            )
                            .foregroundColor(isEnrolled ? Color("ThirdColor").opacity(0.8) : Color("ThirdColor")) // ✅ Muted text color when enrolled
                            .bold()
                            .clipShape(Capsule())
                            .overlay(
                                Capsule().stroke(Color("ThirdColor"), lineWidth: isEnrolled ? 2 : 0) // ✅ Add subtle border when enrolled
                            )
                            .opacity(isEnrolled ? 0.8 : 1.0) // ✅ Slightly dim when enrolled
                    }
                    
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
    UniversityCard(university: ApiUniversity(name: "Stockholms University", country: "Sweden"))
        .environmentObject(DbConnection())
}
