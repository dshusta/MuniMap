import Quick
import Nimble

// Mocks by subclassing, like an animal.
class MockURLSessionDataTask : NSURLSessionDataTask {
    override func resume() {
        
    }
}

class ApiClientSpec: QuickSpec {
    override func spec() {
        class MockURLSession : NSURLSession {
            override init() {}
            var lastURL : NSURL!
            var lastCompletionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!

            private override func dataTaskWithURL(url: NSURL, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)?) -> NSURLSessionDataTask {
                lastURL = url
                lastCompletionHandler = completionHandler
                return MockURLSessionDataTask()
            }
        }

        var urlSession : MockURLSession!
        var subject : ApiClient!

        beforeEach {
            urlSession = MockURLSession()
            subject = ApiClient(URLSession: urlSession, apiToken: "TOKEN")
        }

        describe("getting all the routes for Muni") {
            var routes : [Route]!
            beforeEach{
                subject.fetchAllRoutes({ (parsedRoutes : [Route]) -> () in
                    routes = parsedRoutes
                })
            }

            it("should fetch routes from the url session") {
                let path =  "http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?token=TOKEN&agencyName=SF-MUNI"
                expect(urlSession.lastURL).to(equal(NSURL(string: path)))
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
    }
}
