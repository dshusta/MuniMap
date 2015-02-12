import Foundation
import MapKit

class StopsParser : NSObject, NSXMLParserDelegate {
    var collectedStops : [Stop]
    let stops : [String: CLLocationCoordinate2D]

    override init() {
        collectedStops = []

        let stopsReferenceURL = NSBundle.mainBundle().URLForResource("stops", withExtension: "csv")!
        var stopsCSV = NSArray(contentsOfCSVURL: stopsReferenceURL) as! [[String]]
        stopsCSV.removeAtIndex(0)

        var permaStops = [String: CLLocationCoordinate2D]()
        for row in stopsCSV {
            let stopString = "1" + row[0]
            let stopLatitude = row[3]
            let stopLongitude = row[4]

            permaStops[stopString] = CLLocationCoordinate2DMake((stopLatitude as NSString).doubleValue,
                                                                (stopLongitude as NSString).doubleValue)
        }

        stops = permaStops
    }

    func parseStopsData(data: NSData) -> [Stop]! {
        collectedStops = []

        var xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = self

        xmlParser.parse()

        return collectedStops
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        if (elementName == "Stop") {
            let name = attributeDict["name"] as! String
            let stopCode = attributeDict["StopCode"] as! String
            let stopCoordinate = stops[stopCode]
            if (stopCoordinate != nil) {
                let stop = Stop(name: name,
                    stopCode: stopCode,
                    stopCoordinate: stopCoordinate!)

                collectedStops += [stop]
            } else {
                println("No stop found for \(name) - \(stopCode)")
            }
        }
    }
}
