import Quick
import Nimble
import UIKit
import MapKit

class RootViewControllerSpec: QuickSpec {
    override func spec() {
        class MockApiClient: ApiClient {
            var lastRoutesCompletion: (([Route]) -> ())!
            var lastStopsCompletion: (([Stop]) -> ())!
            var routeCodesForStops: [String]

            override init(URLSession session: NSURLSession, apiToken token: String) {
                routeCodesForStops = []
                super.init(URLSession: session, apiToken: token)
            }

            private override func fetchAllRoutes(routes: ([Route]) -> ()) {
                lastRoutesCompletion = routes
            }

            private override func fetchStopsForRouteCode(routeCode: String, inboundOrOutbound: RouteDirection, stops: ([Stop]) -> ()) {
                lastStopsCompletion = stops
                routeCodesForStops += [routeCode]
            }
        }

        var subject : RootViewController!
        var apiClient: MockApiClient!
        var navigationController: UINavigationController!

        beforeEach {
            apiClient = MockApiClient(URLSession: NSURLSession.sharedSession(), apiToken: "")
            subject = RootViewController(apiClient: apiClient)
            navigationController = UINavigationController(rootViewController: subject)

            expect(subject.view).toNot(beNil())
        }

        it("have a mapview that starts in San Francisco") {
            expect(subject.mapview).toNot(beNil())

            let buenaVistaPark = CLLocationCoordinate2DMake(37.768783, -122.442113)
            let buenaVistaPoint = MKMapPointForCoordinate(buenaVistaPark)
            let visibleMapRect = subject.mapview.visibleMapRect
            expect(MKMapRectContainsPoint(visibleMapRect, buenaVistaPoint)).to(beTruthy())

            let vegas = CLLocationCoordinate2DMake(36.168773, -115.146505)
            let vegasPoint = MKMapPointForCoordinate(vegas)
            expect(MKMapRectContainsPoint(visibleMapRect, vegasPoint)).to(beFalsy())
        }

        it("should fetch routes for SF-Muni") {
            expect(apiClient.lastRoutesCompletion).toNot(beNil())
        }

        context("when the routes are fetched") {
            beforeEach {
                let route1 = Route(name: "Route1", code: "123", inboundName: "Inbound", outboundName: "Outbound")
                let route2 = Route(name: "Route2", code: "345", inboundName: "Inbound", outboundName: nil)

                apiClient.lastRoutesCompletion([route1, route2])
            }

            it("should fetch stops for each route") {
                expect(apiClient.routeCodesForStops).to(equal(["123", "123", "345"]))
            }

            context("each time a route's stops are returned") {
                beforeEach {
                    let coordinate1 = CLLocationCoordinate2DMake(30, 100)
                    let stop1 = Stop(name: "Stop1", stopCode: "abc", stopCoordinate: coordinate1)

                    let coordinate2 = CLLocationCoordinate2DMake(50, 90)
                    let stop2 = Stop(name: "Stop2", stopCode: "def", stopCoordinate: coordinate2)

                    apiClient.lastStopsCompletion([stop1, stop2])
                }

                it("should place a pin on the map for each stop") {
                    let annotations = subject.mapview.annotations as! [MuniAnnotation]
                    let sortedAnnotations = annotations.sorted({ (annotation1: MuniAnnotation, annotation2: MuniAnnotation) -> Bool in
                        return annotation1.title < annotation2.title
                    })
                    
                    expect(sortedAnnotations[0].coordinate.latitude).to(equal(30))
                    expect(sortedAnnotations[0].coordinate.longitude).to(equal(100))

                    expect(sortedAnnotations[1].coordinate.latitude).to(equal(50))
                    expect(sortedAnnotations[1].coordinate.longitude).to(equal(90))
                }
            }
        }

        context("when user taps the Nearby button") {
            beforeEach {
                subject.navigationItem.rightBarButtonItem!.tap()
            }

            it("should show a list of Nearby stops") {
                expect(navigationController.topViewController).to(beAnInstanceOf(NearbyViewController))
            }
        }
    }
}
