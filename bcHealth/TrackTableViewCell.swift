import UIKit

class TrackTableViewCell: UITableViewCell {
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var averageSpeed: UILabel!
    @IBOutlet weak var speedUnit: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var distanceUnit: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timeUnit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
