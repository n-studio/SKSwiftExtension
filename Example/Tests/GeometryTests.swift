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
        }
    }
}