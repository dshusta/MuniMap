import UIKit
import MapKit

class RootViewController: UIViewController {
    var mapview : MKMapView!
    var apiClient : ApiClient!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        apiClient = ApiClient(URLSession: NSURLSession.sharedSession(), apiToken: "b4aed8bc-5bdb-455b-b905-c1208ff30e2e")
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        apiClient = ApiClient(URLSession: NSURLSession.sharedSession(), apiToken: "b4aed8bc-5bdb-455b-b905-c1208ff30e2e")
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

