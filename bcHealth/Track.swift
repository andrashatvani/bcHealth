import Foundation

struct Track {
    var date:Date?
    var city:String?
    var distance:Decimal?
    var distanceUnit:String?
    var time:Decimal?
    var timeUnit:String?
    var averageSpeed:Decimal?
    var speedUnit:String?
    
    func isComplete() -> Bool {
        return (date != nil)
            && ((city != nil) && (city != ""))
            && (distance != nil)
            && ((distanceUnit != nil) && (distanceUnit != ""))
            && (time != nil)
            && ((timeUnit != nil) && (timeUnit != ""))
            && (averageSpeed != nil)
            && ((speedUnit != nil) && (speedUnit != ""))
    }
}
