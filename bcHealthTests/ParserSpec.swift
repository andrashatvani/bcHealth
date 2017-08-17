import Quick
import Nimble
@testable import bcHealth

class ParserSpec: QuickSpec {
    var contents = ""
    var parser = Parser()
    override func spec() {
        describe("Parser") {
            it("adds incomplete track to list of incomplete tracks") {
                let path:String? = Bundle(for: type(of: self)).path(forResource: "oneIncomplete", ofType: "html", inDirectory: "trackLists")
                self.contents = try! String(contentsOfFile: path!)
                
                let (completeTracks, incompleteTracks) = try! self.parser.parse(trackListHtml: self.contents)
                
                expect(completeTracks).to(haveCount(39))
                expect(incompleteTracks).to(haveCount(1))
            }
            
            it("throws emptyDocument error if html is empty") {
                expect { try self.parser.parse(trackListHtml: "") }.to(throwError(ParseError.emptyDocument))
            }
            
            it("parses a complete document") {
                let path:String? = Bundle(for: type(of: self)).path(forResource: "fullyComplete", ofType: "html", inDirectory: "./trackLists")
                self.contents = try! String(contentsOfFile: path!)
                
                let (completeTracks, incompleteTracks) = try! self.parser.parse(trackListHtml: self.contents)
                
                expect(completeTracks).to(haveCount(40))
                expect(incompleteTracks).to(haveCount(0))
            }
        }
    }
}
