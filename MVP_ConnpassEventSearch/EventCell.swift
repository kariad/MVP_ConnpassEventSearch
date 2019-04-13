import UIKit
import PureLayout

class EventCell: UITableViewCell {
    let startedAtLabel = UILabel()
    let titleLabel = UILabel()
    let catchCopyLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.accessoryType = .disclosureIndicator
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(_ event: ConnpassEvent) {
        self.addSubviews()
        self.startedAtLabel.text = self.parseDate(from: event.startedAt)
        self.startedAtLabel.font = UIFont.systemFont(ofSize: 15.0)
        self.titleLabel.text = event.title
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        self.catchCopyLabel.text = event.catchCopy
        self.catchCopyLabel.font = UIFont.systemFont(ofSize: 15.0)
        self.addConstraints()
    }

    func addSubviews() {
        self.addSubview(self.startedAtLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.catchCopyLabel)
    }

    func addConstraints() {
        self.startedAtLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10.0)
        self.startedAtLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)

        self.titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        self.titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 30.0)

        self.catchCopyLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        self.catchCopyLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15.0)
        self.catchCopyLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 30.0)
    }

    func parseDate(from dateString: String) -> String {
        let InputdateFormatter = DateFormatter()
        InputdateFormatter.locale = Locale(identifier: "en_US_POSIX")
        InputdateFormatter.calendar = Calendar(identifier: .gregorian)
        InputdateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let date = InputdateFormatter.date(from: dateString)
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateStyle = .short
        outputDateFormatter.timeStyle = .short
        outputDateFormatter.locale = Locale(identifier: "ja_JP")
        outputDateFormatter.calendar = Calendar(identifier: .gregorian)
        return outputDateFormatter.string(from: date!)
    }
}
