import Foundation

class RoutesParser: NSObject, NSXMLParserDelegate {
    var collectedRoutes : [Route]
    var currentRoute : Route?

    override init() {
        collectedRoutes = []
    }

    func parseRoutesData(data : NSData) -> [Route]! {
        collectedRoutes = []

        var xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = self

        xmlParser.parse()

        return collectedRoutes
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        if (elementName == "Route") {
            let routeName = attributeDict["Name"] as! String
            let routeCode = attributeDict["Code"] as! String

            currentRoute = Route(name: routeName, code: routeCode, inboundName: nil, outboundName: nil)
        }

        if (elementName == "RouteDirection") {
            let directionName = attributeDict["Name"] as! String
            let directionCode = attributeDict["Code"] as! String

            if (directionCode == "Inbound") {
                currentRoute!.inboundName = directionName
            }
            else if (directionCode == "Outbound") {
                currentRoute!.outboundName = directionName
            }
        }
    }

    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "Route") {
            collectedRoutes += [currentRoute!]
            currentRoute = nil
        }
    }
}
