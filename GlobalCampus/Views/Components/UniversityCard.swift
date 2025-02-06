import SwiftUI

struct UniversityCard: View {
    var university: ApiUniversity
    
    var body: some View {
        VStack(alignment: .center) {
            Text(university.name)
                .foregroundStyle(.white)
                .bold()
            
            Text(university.country)
                .foregroundStyle(.white)
                .bold()
            
            Spacer()
            
            HStack {
                Button("Enroll") {
                    // function to add to user list
                }
                .padding()
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
                .background(Color("ButtonColor"))
                .foregroundColor(Color("PrimaryColor"))
                .bold()
                .cornerRadius(8)
                
                Spacer()
            }
        }
        .padding()
        .frame(width: 325, height: 200, alignment: .leading)
        .background(Color("PrimaryColor"))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}

#Preview {
    UniversityCard(university: ApiUniversity(name: "Stockholms University", country: "Sweden"))
}
