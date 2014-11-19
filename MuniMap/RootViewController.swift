import UIKit
import MapKit

class RootViewController: UIViewController {
    var mapview : MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapview = MKMapView(frame: view.bounds)
        mapview.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        view.addSubview(mapview)

        let span = MKCoordinateSpanMake(0.25, 0.25)
        let buenaVistaPark = CLLocationCoordinate2DMake(37.768783, -122.442113)
        let region = MKCoordinateRegionMake(buenaVistaPark, span)
        mapview.region = region
    }
}

