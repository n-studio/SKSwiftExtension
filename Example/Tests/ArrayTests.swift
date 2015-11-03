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
                expect(4) == array.count
            }
            
            it("remove several objects") {
                var array = ["Hello", 4, 2, 4.0, "Goodbye"]
                array.removeObject(4)
                expect(3) == array.count
            }
            
            it("remove several objects") {
                var array = ["Hello", 4, 2, 4.0, "Goodbye"]
                array.removeObject(4.0)
                expect(3) == array.count
            }
        }
    }
}