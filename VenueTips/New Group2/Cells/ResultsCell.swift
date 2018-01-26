import UIKit

class ResultsCell: UITableViewCell {

    lazy var venueImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8.0
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var venueAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "ResultsCell")
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    //TODO Configure Cell with venue and Image 
    
    private func setupViews() {
        setupVenueImageView()
        setupVenueNameLabel()
        setupVenueAddressLabel()
    }
    
    private func setupVenueImageView() {
        self.addSubview(venueImageView)
        venueImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(90)
            make.leading.equalTo(5)
            make.top.equalTo(5)
        }
    }
    
    private func setupVenueNameLabel() {
        self.addSubview(venueNameLabel)
        venueNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.leading.equalTo(self.venueImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-5)
            
        }
        
    }
    
    private func setupVenueAddressLabel() {
        self.addSubview(venueAddressLabel)
        venueAddressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.venueNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.venueImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-5)
            
    }
}
}

