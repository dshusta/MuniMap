import Quick
import Nimble

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

            expect(stops[1].name).to(equal("2nd St and Harrison St"))
            expect(stops[1].stopCode).to(equal("13009"))
        }
    }
}
