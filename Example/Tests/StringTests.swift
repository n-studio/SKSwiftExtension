// https://github.com/Quick/Quick

import Quick
import Nimble
import SKSwiftExtension

class StringSpec: QuickSpec {
    override func spec() {
        describe("String extension are working as expected") {
            it("support subscript with range") {
                expect("hello"[0...1]).to(equal("he"))
            }
            it("support subscript with range out of range") {
                expect("hello"[0...9]).to(equal("he"))
            }
            it("support subscript with negative range") {
                expect("hello"[-3 ... -1]).to(equal("llo"))
                
            }
            it("support subscript with out of range negative range") {
                expect("hello"[-9 ... -1]).to(equal("hello"))
            }
        }
    }
}