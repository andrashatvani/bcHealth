import Foundation
import Kanna
import SwiftyBeaver

class Parser {
    public static let dateFormatter:DateFormatter = {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm:ss a"
        return dateFormatter
    }()
    
    func parse(trackListHtml:String) throws -> ([Track], [Track]) {
        let console = ConsoleDestination()
        let log = SwiftyBeaver.self
        log.addDestination(console)
        var completeTracks:[Track] = []
        var incompleteTracks:[Track] = []
        guard let doc:HTMLDocument = HTML(html: trackListHtml, encoding: .utf8) else {
            throw ParseError.emptyDocument
        }
        
        let tracklist:XPathObject = doc.css(".tracklist > li[ng-repeat]")
        for element:XMLElement in tracklist {
            var track:Track = Track()
            parseMetrics(element, &track)
            parseCity(element, &track)
            parseDate(element, &track)
            if (track.isComplete()) {
                completeTracks.append(track)
                log.info("Track: \(track)")
            } else {
                incompleteTracks.append(track)
                log.warning("Track: \(track)")
            }
        }
        return (completeTracks, incompleteTracks)
    }
    
    fileprivate func parseCity(_ element: XMLElement, _ track: inout Track) {
        if let city:String = element.at_css("h3")?.text {
            track.city = city
                .replacingOccurrences(of: "track in", with: "", options: .caseInsensitive)
                .trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            print("Couldn't find city")
        }
    }
    
    fileprivate func parseMetrics(_ element: XMLElement, _ track: inout Track) {
        for entry:XMLElement in element.css("ul > li") {
            if let label:String = entry.at_css("label")?.text {
                switch label {
                case "Distance":
                    (track.distance, track.distanceUnit) = parseProperty(entry: entry)
                case "Time":
                    (track.time, track.timeUnit) = parseProperty(entry: entry)
                case "Speed":
                    (track.averageSpeed, track.speedUnit) = parseProperty(entry: entry)
                default:
                    print("Unknown element ", label )
                }
            } else {
                print("Couldn't find labels")
            }
        }
    }
    
    fileprivate func parseDate(_ element: XMLElement, _ track: inout Track) {
        if let rawDate:String = element .at_css("p")?.text {
            track.date = Parser.dateFormatter.date(from: rawDate)
        } else {
            print("Couldn't find date")
        }
    }
    
    fileprivate func parseProperty(entry:XMLElement) -> (Decimal?, String?) {
        var decimalValue:Decimal?
        var stringValue:String?
        if let rawText = entry.at_xpath("text()")?.text {
            decimalValue = 0.0
            Scanner(string: rawText).scanDecimal(&decimalValue!)
            stringValue = entry.at_css("span")?.text
        }
        
        return (decimalValue, stringValue)
    }
}
