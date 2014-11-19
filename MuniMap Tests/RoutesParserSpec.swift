import Quick
import Nimble

class RoutesParserSpec: QuickSpec {
    override func spec() {
        var subject : RoutesParser!

        beforeEach {
            subject = RoutesParser()
        }

        it("should be able to parse routes") {
            let routesURL = NSBundle(forClass: self.dynamicType).URLForResource("routes", withExtension: "xml")!
            let routesData = NSData(contentsOfURL: routesURL)!

            let routes = subject.parseRoutesData(routesData)
            let route = routes![0]

            expect(route.name).to(equal("1-California"))
            expect(route.code).to(equal("1"))
            expect(route.inboundName).to(equal("Inbound to Downtown"))
            expect(route.outboundName).to(equal("Outbound to The Richmond District"))

        }
    }
}
