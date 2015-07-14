import Foundation



class ApiClient {
    let urlSession : NSURLSession
    let apiToken : String
    let routesParser = RoutesParser()
    let stopsParser = StopsParser()

    init(URLSession session : NSURLSession, apiToken token: String ) {
        urlSession = session
        apiToken = token
    }

    func fetchAllRoutes(routes: ([Route]) -> ()) {
        let path = "http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?token=\(apiToken)&agencyName=SF-MUNI"
        let dataTask = urlSession.dataTaskWithURL(NSURL(string: path)!, completionHandler: { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            routes(self.routesParser.parseRoutesData(data))
        })
        dataTask.resume()
    }

    enum RouteDirection {
        case Inbound, Outbound
        func description() -> String {
            return self == .Inbound ? "Inbound" : "Outbound"
        }
    }
    
    func fetchStopsForRouteCode(routeCode: String, inboundOrOutbound: RouteDirection, stops: ([Stop]) -> ()) {
        let routeIdentifier = "SF-MUNI~\(routeCode)~\(inboundOrOutbound.description())"
        let path = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?token=\(apiToken)&routeIDF=\(routeIdentifier)"

        let dataTask = urlSession.dataTaskWithURL(NSURL(string: path)!, completionHandler: { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            stops(self.stopsParser.parseStopsData(data))
        })
        dataTask.resume()
    }
}
