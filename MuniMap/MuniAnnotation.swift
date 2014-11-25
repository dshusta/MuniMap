import MapKit

class MuniAnnotation: NSObject, MKAnnotation {
    let coordinate : CLLocationCoordinate2D
    let title : String

    init(coordinate initCoordinate: CLLocationCoordinate2D, title initTitle: String) {
        coordinate = initCoordinate
        title = initTitle
    }


}

