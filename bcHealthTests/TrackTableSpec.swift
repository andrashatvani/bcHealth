import Foundation
import Quick
import Nimble
import XCTest
@testable import bcHealth

class TrackTableSpec: QuickSpec {
    var contents = ""
    var parser = Parser()
    override func spec() {
        describe("TrackTable") {
            it("starts") {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let trackTableViewController = storyboard.instantiateViewController(withIdentifier: "TrackTableViewController") as! TrackTableViewController

                let path:String? = Bundle(for: type(of: self)).path(forResource: "oneIncomplete", ofType: "html", inDirectory: "trackLists")
                self.contents = try! String(contentsOfFile: path!)
                
                (trackTableViewController.completeTracks, trackTableViewController.incompleteTracks) = try! self.parser.parse(trackListHtml: self.contents)
            }
        }
    }
}
