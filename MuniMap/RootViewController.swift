import UIKit
import MapKit

class RootViewController: UIViewController {
    var mapview : MKMapView!
    var apiClient : ApiClient!

    init(apiClient newApiClient: ApiClient?) {
        super.init(nibName: nil, bundle: nil)
        apiClient = newApiClient
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mapview = MKMapView(frame: view.bounds)
        mapview.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        view.addSubview(mapview)

        let span = MKCoordinateSpanMake(0.25, 0.25)
        let buenaVistaPark = CLLocationCoordinate2DMake(37.768783, -122.442113)
        let region = MKCoordinateRegionMake(buenaVistaPark, span)
        mapview.region = region
//
//        println("Starting to fetch")
//        apiClient.fetchAllRoutes { (parsedRoutes : [Route]) -> () in
//            println("End fetch: \(parsedRoutes)")
//        }
    }
}

