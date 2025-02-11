import SwiftUI
import MapKit

struct AboutCompanyView: View {
    @State var companyPosition = MapCameraPosition
        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.3454741630426, longitude: 18.10185215340714), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    
    @State var ourCompany: [Company] = [Company(name: "GlobalCampus", location: Location(latitude: 59.3454741630426, longitude: 18.10185215340714))]
    
    var body: some View {
        ZStack {
            Map(position: $companyPosition) {
                ForEach(ourCompany) { company in
                    
                    Annotation(company.name, coordinate: CLLocationCoordinate2D(latitude: company.location.latitude, longitude: company.location.longitude)) {
                        ZStack {
                            Circle()
                                .foregroundStyle(.red)
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    AboutCompanyView()
}
