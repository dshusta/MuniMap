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

            expect(stops[2].name).to(equal("32nd Ave and California St"))
            expect(stops[2].stopCode).to(equal("13547"))
            expect(stops[2].stopCoordinate.latitude).to(equal(37.783429))
            expect(stops[2].stopCoordinate.longitude).to(equal(-122.492553))

            expect(stops[3].name).to(equal("32nd Ave and Clement St"))
            expect(stops[3].stopCode).to(equal("13549"))
            expect(stops[3].stopCoordinate.latitude).to(equal(37.781802))
            expect(stops[3].stopCoordinate.longitude).to(equal(-122.492425))
        }
    }
}
