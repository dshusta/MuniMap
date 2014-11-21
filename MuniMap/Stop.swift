import Foundation
import MapKit

struct Stop : Printable {
    var name : String
    var stopCode : String
    var stopCoordinate : CLLocationCoordinate2D

    var description : String {
        return "\(name) - \(stopCode) - (\(stopCoordinate.latitude), \(stopCoordinate.longitude))"
    }
}
