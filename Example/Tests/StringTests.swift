// https://github.com/Quick/Quick

import Quick
import Nimble
import SKSwiftExtension

class StringSpec: QuickSpec {
    override func spec() {
        describe("String supports support subscript with range") {
            it("supports normal range") {
                expect("hello world"[ 0 ..< 2 ]).to(equal("he"))
                expect("hello world"[ 1 ..< 3 ]).to(equal("el"))
                expect("hello world"[ 2 ..< 5 ]).to(equal("llo"))
            }
            it("supports negative range") {
                expect("hello"[-3 ... -1]).to(equal("llo"))
                expect("hello"[-3 ..< -1]).to(equal("ll"))
                expect("hello"[0 ..< 3]).to(equal("hel"))
                expect("hello"[0 ... 4]).to(equal("hello"))
                expect("hello"[-1 ... 0]).to(equal("hello"))
                expect("hello world"[-5 ... -4]).to(equal("wo"))
                expect("hello world"[-5 ... -5]).to(equal("w"))
                expect("(1)"[-2 ..< 2]).to(equal("1"))
            }
            context("if out of range") {
                it("it still works") {
                    expect("hello"[0...14]).to(equal("hello"))
                    expect("hello"[-5 ... 7]).to(equal("hello"))
                    expect("hello"[-3 ..< 0]).to(equal("llo"))
                    expect("hello"[-14 ... -1]).to(equal("hello"))
                    expect("hello"[-14 ... 7]).to(equal("hello"))
                    expect("hello"[-14 ..< 7]).to(equal("hello"))
                }
            }
            context("nil length range") {
                it("it still works") {
                    expect("hello"[0...0]).to(equal("h"))
                    expect("hello"[0..<0]).to(equal(""))
                    expect("hello"[1...1]).to(equal("e"))
                    expect("hello"[1..<1]).to(equal(""))
                    expect("hello"[2..<2]).to(equal(""))
                    expect("hello"[3..<3]).to(equal(""))
                    expect("hello"[-4 ..< -4]).to(equal(""))
                    expect("hello"[-4 ... -4]).to(equal("e"))
                }
            }
        }
        
        describe("String supports replace") {
            it("supports replace with string pattern") {
                expect("hello world".replacingOccurrences(of: "world", with: "kitty")).to(equal("hello kitty"))
            }
            context("if case sensitivity is enabled") {
                it("it doesn't replace if case doesn't match") {
                    expect("hello world".replacingOccurrences(of: "World", with: "kitty")).to(equal("hello world"))
                }
            }
            context("if case sensitivity is disabled") {
                it("it replaces even if case doesn't match") {
                    expect("hello world".replace("World", withString: "kitty", options: ["caseSensitive": false as AnyObject])).to(equal("hello kitty"))
                }
            }
        }
        
        describe("ranges") {
            it("converts range to nsrange and nsrange to range") {
                let string = "a👿b🇩🇪c"
                let range = string.range(of: "🇩🇪")!
                
                // String range to NSRange:
                let nsrange = string.nsRange(from: range)
                expect((string as NSString).substring(with: nsrange)).to(equal("🇩🇪"))
                
                // NSRange back to String range:
                let range2 = string.range(from: nsrange)!
                expect(string.substring(with: range2)).to(equal("🇩🇪"))
            }
        }
    }
}
