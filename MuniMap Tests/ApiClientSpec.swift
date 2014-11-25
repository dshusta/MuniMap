import Quick
import Nimble

// Mocks by subclassing, like an animal.
class MockURLSessionDataTask : NSURLSessionDataTask {
    var didResume : Bool = false
    override func resume() {
        didResume = true
    }
}

class ApiClientSpec: QuickSpec {
    override func spec() {
        class MockURLSession : NSURLSession {
            override init() {}
            var lastURL : NSURL!
            var lastCompletionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!
            var lastDataTask : MockURLSessionDataTask!

            private override func dataTaskWithURL(url: NSURL, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)?) -> NSURLSessionDataTask {
                lastURL = url
                lastCompletionHandler = completionHandler
                lastDataTask = MockURLSessionDataTask()
                return lastDataTask
            }
        }

        var urlSession : MockURLSession!
        var subject : ApiClient!

        beforeEach {
            urlSession = MockURLSession()
            subject = ApiClient(URLSession: urlSession, apiToken: "TOKEN")
        }

        describe("getting all the routes for Muni") {
            var routes : [Route]?
            beforeEach{
                subject.fetchAllRoutes({ (parsedRoutes : [Route]) -> () in
                    routes = parsedRoutes
                })
            }

            it("should fetch routes from the url session") {
                let path =  "http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?token=TOKEN&agencyName=SF-MUNI"
                expect(urlSession.lastURL).to(equal(NSURL(string: path)))
                expect(urlSession.lastDataTask.didResume).to(beTruthy())
            }

            context("when the urlSession successfully fetches routes") {
                beforeEach {
                    let routesURL = NSBundle(forClass: self.dynamicType).URLForResource("routes", withExtension: "xml")!
                    let routesData = NSData(contentsOfURL: routesURL)!

                    urlSession.lastCompletionHandler(routesData, nil, nil)
                }

                it ("should pass back an array of routes") {
                    let route = routes![0]
                    expect(route.name).to(equal("1-California"))
                }
            }
        }

        describe("getting all of the stops for a route") {
            var stops: [Stop]?
            beforeEach {
                subject.fetchStopsForRouteCode("10", inboundOrOutbound: .Inbound, stops: { (parsedStops: [Stop]) -> () in
                    stops = parsedStops
                })
            }

            it("should fetch routes from the URLSession") {
                let path = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?token=TOKEN&routeIDF=SF-MUNI~10~Inbound"
                expect(urlSession.lastURL).to(equal(NSURL(string: path)))
                expect(urlSession.lastDataTask.didResume).to(beTruthy())
            }

            context("when the urlSession successfully fetches stops") {
                beforeEach {
                    let stopsURL = NSBundle(forClass: self.dynamicType).URLForResource("stops", withExtension: "xml")!
                    let stopsData = NSData(contentsOfURL: stopsURL)!

                    urlSession.lastCompletionHandler(stopsData, nil, nil)
                }

                it("should pass back an array of stops") {
                    let firstStop = stops![0]
                    expect(firstStop.name).to(equal("2nd St and Brannan St"))
                    expect(firstStop.stopCode).to(equal("13003"))
                    expect(firstStop.stopCoordinate.latitude).to(equal(37.781827))
                    expect(firstStop.stopCoordinate.longitude).to(equal(-122.391945))

                    expect(countElements(stops!)).to(equal(2))
                }
            }
        }
    }
}
