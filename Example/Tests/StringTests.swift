// https://github.com/Quick/Quick

import Quick
import Nimble
import SKSwiftExtension

class StringSpec: QuickSpec {
    override func spec() {
        describe("String supports support subscript with range") {
            it("supports normal range") {
                expect("hello world"[0..<2]).to(equal("he"))
            }
            context("if out of range") {
                it("it still works") {
                    expect("hello"[0...9]).to(equal("hello"))
                }
            }
            context("if out of range") {
                it("support subscript with negative range") {
                    expect("hello world"[-5 ... -1]).to(equal("world"))
                }
            }
            context("if out of range") {
                it("support subscript with out of range negative range") {
                    expect("hello"[-9 ... -1]).to(equal("hello"))
                }
            }
        }
        
        describe("String supports replace") {
            it("supports replace with string pattern") {
                expect("hello world".replace("world", withString: "kitty")).to(equal("hello kitty"))
            }
            context("if case sensitivity is enabled") {
                it("it doesn't replace if case doesn't match") {
                    expect("hello world".replace("World", withString: "kitty")).to(equal("hello world"))
                }
            }
            context("if case sensitivity is disabled") {
                it("it replaces even if case doesn't match") {
                    expect("hello world".replace("World", withString: "kitty", options: ["caseSensitive": false])).to(equal("hello kitty"))
                }
            }
        }
    }
}