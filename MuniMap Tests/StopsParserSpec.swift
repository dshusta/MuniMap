import Quick
import Nimble
import MapKit

class StopsParserSpec: QuickSpec {
    override func spec() {
        var subject : StopsParser!

        beforeEach {
            subject = StopsParser()
        }

        it("should be able to parse stops") {
            let stopsFixtureURL = NSBundle(forClass: self.dynamicType).URLForResource("stops", withExtension: "xml")!
            let stopsData = NSData(contentsOfURL: stopsFixtureURL)!

            let stops = subject.parseStopsData(stopsData)

            expect(stops[0].name).to(equal("2nd St and Brannan St"))
            expect(stops[0].stopCode).to(equal("13003"))
            expect(stops[0].stopCoordinate.latitude).to(equal(37.781827))
            expect(stops[0].stopCoordinate.longitude).to(equal(-122.391945))

            expect(stops[1].name).to(equal("2nd St and Harrison St"))
            expect(stops[1].stopCode).to(equal("13009"))
            expect(stops[1].stopCoordinate.latitude).to(equal(37.784532))
            expect(stops[1].stopCoordinate.longitude).to(equal(-122.395325))
        }
    }
}
