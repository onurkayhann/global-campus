import SwiftUI

struct UniversityCard: View {
    @EnvironmentObject var db: DbConnection
    var university: ApiUniversity

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
                            db.deleteUniversityFromApplication(universityName: universityName)
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
                                ? Color("PrimaryColor").opacity(0.7)
                                : Color("ButtonColor")
                            )
                            .foregroundColor(isEnrolled ? Color("ThirdColor").opacity(0.8) : Color("ThirdColor"))
                            .bold()
                            .clipShape(Capsule())
                            .overlay(
                                Capsule().stroke(Color("ThirdColor"), lineWidth: isEnrolled ? 2 : 0)
                            )
                            .opacity(isEnrolled ? 0.8 : 1.0)
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
