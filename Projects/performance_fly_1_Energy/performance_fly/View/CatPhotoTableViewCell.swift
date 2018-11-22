
import UIKit



class CatPhotoTableViewCell: UITableViewCell {
    let userImageHeight:CGFloat = 30
    
    private var photoModel: PhotoModel? = nil
    

    
    @IBOutlet weak var userAvatarImageView: AsyncImageView!
    @IBOutlet weak var photoImageView: AsyncImageView!
    @IBOutlet weak var photoTimeIntevalSincePostLabel: UILabel!

    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var photosLikeLabel: UILabel!
    @IBOutlet weak var photosDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        [userNameLabel!, photosLikeLabel!, photosDescriptionLabel!, photoTimeIntevalSincePostLabel!].forEach {
            $0.backgroundColor = UIColor.white
        }
    

        userAvatarImageView.layer.contents = UIImage(named: "placeholder")!.makeCircularImage(with: CGSize(width: userImageHeight, height: userImageHeight))?.cgImage
        userAvatarImageView.backgroundColor = UIColor.white
        userAvatarImageView.layer.cornerRadius = userImageHeight/2.0
        userAvatarImageView.clipsToBounds = true
        
        
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.layer.contents = UIImage(named: "placeholder")!.makeCircularImage(with: CGSize(width: 375, height: 375))?.cgImage
        photoImageView.layer.cornerRadius = 2.0

        
    }
    


    
    //MARK: Setup
    
    func downloadAndProcessUserAvatar(forPhoto photoModel: PhotoModel) {
        UIImage.downloadImage(for: photoModel.url) { (image, realURL) in
            photoModel.url = realURL
            if self.photoModel == photoModel, let image = image {
                
                //  这句话很重要 self.photoModel == photoModel,
                //  KV
                //  SDWebImage 的精华
                
                photoModel.url = realURL
                
                self.userAvatarImageView.image = image
            }
        }
    }
    
    

    
    //MARK: Cell Reuse   外部方法
    func updateCell(with photo: PhotoModel?) {
        photoModel = photo
        
        guard let photoModel = photoModel else { return }
        
        userNameLabel.attributedText = photoModel.ownerUserProfile?.usernameAttributedString(withFontSize: 14.0)
        photoTimeIntevalSincePostLabel.attributedText = photoModel.uploadDateAttributedString(withFontSize: 14.0)
        photosLikeLabel.attributedText = photoModel.likesAttributedString(withFontSize: 14.0)
        photosDescriptionLabel.attributedText = photoModel.descriptionAttributedString(withFontSize: 14.0)
        
        
        addShadows()
        
        
        
        self.imageHeightConstraint.constant = (photoModel.height!/photoModel.width!) * self.contentView.bounds.size.width
        
        [userNameLabel!, photosLikeLabel!, photosDescriptionLabel!, photoTimeIntevalSincePostLabel!].forEach {
            $0.sizeToFit()
        }
   
        var rect = photosDescriptionLabel.frame
        let availableWidth = bounds.size.width - 20
        rect.size = photosDescriptionLabel.sizeThatFits(CGSize(width: availableWidth, height: CGFloat.greatestFiniteMagnitude))
        photosDescriptionLabel.frame = rect
        
        
        UIImage.downloadImage(for: photoModel.url) { (image, realURL) in
            photoModel.url = realURL
            if self.photoModel == photo {
                self.photoImageView.image = image
            }
        }
        downloadAndProcessUserAvatar(forPhoto: photoModel)
    }
    

    
    override func prepareForReuse() {
        userAvatarImageView.layer.contents = nil
        photoImageView.layer.contents = nil
        
        userNameLabel.attributedText                   = nil
        photoTimeIntevalSincePostLabel.attributedText = nil
        photosLikeLabel.attributedText                 = nil
        photosDescriptionLabel.attributedText           = nil
    }
    
    

}

extension CatPhotoTableViewCell {

    
    
 
    
    class func height(forPhoto photoModel: PhotoModel, with width: CGFloat) -> CGFloat {

        let photoHeight = width * (photoModel.height!/photoModel.width!)
        
        return 500 - 375 + photoHeight
    }
}




extension CatPhotoTableViewCell{
    
    func addShadows() {
        isOpaque = false
        alpha = 0.1
        
        for label in [photosDescriptionLabel!, userNameLabel!] {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.lightGray
            shadow.shadowOffset = CGSize(width: 0.0, height: 5.0)
            shadow.shadowBlurRadius = 5.0
            if let mutableAttributedString = label.attributedText as? NSMutableAttributedString{
                let range = NSRange(location: 0, length: mutableAttributedString.string.count)
                mutableAttributedString.addAttribute(NSAttributedString.Key.shadow, value: shadow, range: range)
            }
 
        }
    }
    
    
    
    //MARK: Motion
    func panImage(with yRotation: CGFloat) {
        let lowerLimit = bounds.size.width/2 - 10
        let upperLimit = bounds.size.width/2 + 10
        let rotationMult: CGFloat = 5.0
        
        var possibleXOffset = photoImageView.center.x + ((yRotation * -1) * rotationMult * 1)
        
        possibleXOffset = (possibleXOffset < lowerLimit) ? lowerLimit : possibleXOffset
        possibleXOffset = (possibleXOffset > upperLimit) ? upperLimit : possibleXOffset
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseOut], animations: {
            self.photoImageView.center = CGPoint(x: possibleXOffset, y: self.photoImageView.center.y)
        }, completion: nil)
    }
    
}
