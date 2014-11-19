import Foundation



class ApiClient {
    let urlSession : NSURLSession
    let apiToken : String
    let parser = RoutesParser()

    init(URLSession session : NSURLSession, apiToken token: String ) {
        urlSession = session
        apiToken = token
    }

    func fetchAllRoutes(routes: ([Route]) -> ()) {
        let path = "http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?token=\(apiToken)&agencyName=SF-MUNI"
        let dataTask = urlSession.dataTaskWithURL(NSURL(string: path)!, completionHandler: { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            routes(self.parser.parseRoutesData(data))
        })
        dataTask.resume()
    }

}
