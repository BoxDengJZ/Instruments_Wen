//
//  PhotoModel.swift
//  Catstagram-Starter
//
//  Created by Luke Parham on 2/12/17.
//  Copyright © 2017 Luke Parham. All rights reserved.
//

import UIKit

class PhotoModel: NSObject {
    var url: URL?
    var urlKeyStr: String?
    
    var photoID: Int?
    var uploadDateString: String?
    var title: String?
    var descriptionText: String?
    var commentsCount: UInt?
    var likesCount: UInt?
    
    var ownerUserProfile: UserModel?
    
    
    var width: CGFloat?
    var height: CGFloat?

    init(photoDictionary: [String: Any]) {
        
        if let urlStringArray = photoDictionary["image_url"] as? [String]{
            let urlString = urlStringArray.first!
            url              = URL(string: urlString)
        }
        
        uploadDateString = photoDictionary["created_at"] as? String
        photoID          = photoDictionary["id"] as? Int
        urlKeyStr = "\(String(describing: photoID))"
        title            = photoDictionary["title"] as? String
        descriptionText  = photoDictionary["name"] as? String
        commentsCount    = photoDictionary["comments_count"] as? UInt
        likesCount       = photoDictionary["positive_votes_count"] as? UInt
        uploadDateString = "13h"
        
        ownerUserProfile = UserModel(withDictionary: photoDictionary)
        
        
        width = photoDictionary["width"] as? CGFloat
        height = photoDictionary["height"] as? CGFloat
    }
    
    
    
    
    
    func descriptionAttributedString(withFontSize size: CGFloat) -> NSAttributedString {
        guard let username = ownerUserProfile?.username, let descriptionText = descriptionText else { return NSAttributedString() }
        return NSAttributedString(string: "\(username) \(descriptionText)", fontSize: CGFloat(size), color: UIColor.darkGray, firstWordColor: UIColor.darkBlue())
    }
    
    func uploadDateAttributedString(withFontSize size: Float) -> NSAttributedString {
        return NSAttributedString(string: uploadDateString, fontSize: CGFloat(size), color: UIColor.lightGray, firstWordColor: nil)
    }
    
    func likesAttributedString(withFontSize size: Float) -> NSAttributedString {
        guard let likesCount = likesCount else { return NSAttributedString() }
        return NSAttributedString(string: "\(likesCount) likes", fontSize: CGFloat(size), color: UIColor.darkBlue(), firstWordColor: nil)
    }
}
