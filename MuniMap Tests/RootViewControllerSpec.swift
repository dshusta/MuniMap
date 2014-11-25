import Quick
import Nimble
import UIKit
import MapKit

class RootViewControllerSpec: QuickSpec {
    override func spec() {
        var subject : RootViewController!
        beforeEach {
            subject = RootViewController(apiClient: nil)
            expect(subject.view).toNot(beNil())
        }

        it("have a mapview that starts in San Francisco") {
            expect(subject.mapview).toNot(beNil())

            let buenaVistaPark = CLLocationCoordinate2DMake(37.768783, -122.442113)
            let buenaVistaPoint = MKMapPointForCoordinate(buenaVistaPark)
            let visibleMapRect = subject.mapview.visibleMapRect
            expect(MKMapRectContainsPoint(visibleMapRect, buenaVistaPoint)).to(beTruthy())

            let vegas = CLLocationCoordinate2DMake(36.168773, -115.146505)
            let vegasPoint = MKMapPointForCoordinate(vegas)
            expect(MKMapRectContainsPoint(visibleMapRect, vegasPoint)).to(beFalsy())
        }
    }
}
