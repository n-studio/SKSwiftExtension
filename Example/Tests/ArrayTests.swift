// https://github.com/Quick/Quick

import Quick
import Nimble
import SKSwiftExtension

class ArraySpec: QuickSpec {
    override func spec() {
        describe("array extension") {
            
            it("remove object") {
                var array = ["Hello", 1, 2, 4.0, "Goodbye"] as [Any]
                array.removeObject(object: "Goodbye")
                expect(array.count).to(equal(4)) 
            }
            
            it("remove several objects") {
                var array = ["Hello", 4, 2, 4.0, "Goodbye"] as [Any]
                array.removeObject(object: 4)
                expect(array.count).to(equal(4))
            }
            
            it("remove several objects") {
                var array = ["Hello", 4, 2, 4.0, "Goodbye"] as [Any]
                array.removeObject(object: 4.0)
                expect(array.count).to(equal(4))
            }
        }
    }
}
