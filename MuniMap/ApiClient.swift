import Foundation



class ApiClient {
    let urlSession : NSURLSession
    let apiToken : String

    init(URLSession session : NSURLSession, apiToken token: String ) {
        urlSession = session
        apiToken = token
    }

    func fetchAllRoutes(routes: ([Route]) -> ()) {
        let path = "http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?token=\(apiToken)&agencyName=SF-MUNI"
        urlSession.dataTaskWithURL(NSURL(string: path)!, completionHandler: { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            let route = Route(name: "Yes", code: "1", inboundName: nil, outboundName: nil)
            routes([route])
        })
    }

}
