import Foundation

class StopsParser : NSObject, NSXMLParserDelegate {
    var collectedStops : [Stop]

    override init() {
        collectedStops = []
    }

    func parseStopsData(data: NSData) -> [Stop]! {
        collectedStops = []

        var xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = self

        xmlParser.parse()

        return collectedStops
    }

    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        if (elementName == "Stop") {
            let stop = Stop(name: attributeDict["name"] as String,
                        stopCode: attributeDict["StopCode"] as String)

            collectedStops += [stop]
        }
    }
}
