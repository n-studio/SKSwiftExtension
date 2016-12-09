// https://github.com/Quick/Quick

import Quick
import Nimble
import SKSwiftExtension

class GeometrySpec: QuickSpec {
    override func spec() {
        describe("geometry") {
            it("square") {
                expect(9 ** 3).to(equal(9 * 9 * 9))
            }
            
            it("divide") {
                expect(CGPoint(x: 10, y: 10) / CGSize(width: 2, height: 2)).to(equal(CGPoint(x: 5, y: 5)))
            }
        }
    }
}
