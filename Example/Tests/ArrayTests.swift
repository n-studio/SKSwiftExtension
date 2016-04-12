// https://github.com/Quick/Quick

import Quick
import Nimble
import SKSwiftExtension

class ArraySpec: QuickSpec {
    override func spec() {
        describe("array extension") {
            
            it("remove object") {
                var array = ["Hello", 1, 2, 4.0, "Goodbye"]
                array.removeObject("Goodbye")
                expect(array.count).to(equal(4)) 
            }
            
            it("remove several objects") {
                var array = ["Hello", 4, 2, 4.0, "Goodbye"]
                array.removeObject(4)
                expect(array.count).to(equal(3))
            }
            
            it("remove several objects") {
                var array = ["Hello", 4, 2, 4.0, "Goodbye"]
                array.removeObject(4.0)
                expect(array.count).to(equal(3))
            }
        }
    }
}