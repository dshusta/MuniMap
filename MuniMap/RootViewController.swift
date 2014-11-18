import UIKit
import MapKit

class RootViewController: UIViewController {
    @IBOutlet weak var mapview: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let span = MKCoordinateSpanMake(0.25, 0.25);
        let buenaVistaPark = CLLocationCoordinate2DMake(37.768783, -122.442113);
        let region = MKCoordinateRegionMake(buenaVistaPark, span);
        mapview.region = region;
    }
}

