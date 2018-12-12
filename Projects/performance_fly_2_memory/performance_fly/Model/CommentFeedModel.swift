//
//  CommentFeedModel.swift
//  Catstagram-Starter
//
//  Created by Luke Parham on 2/12/17.
//  Copyright © 2017 Luke Parham. All rights reserved.
//

import Foundation

class CommentFeedModel {
    var commentModels = [CommentModel]()
    var photoID: Int
    
    private var urlString: String
    private var currentPage:UInt = 0
    private var totalPages: UInt = 0
    private var totalItems: UInt = 0
    
    private var fetchPageInProgress = false
    private var refreshFeedInProgress = false
    
    init(photoID: Int) {
        self.photoID = photoID
        urlString = "https://api.500px.com/v1/photos/%@/comments?\(photoID)"
    }

    func numberOfItemsInFeed() -> Int {
        return 0
    }
    
    func object(at index: Int) -> CommentModel? {
        if commentModels.count < index && index >= 0 {
            return commentModels[index]
        }
        return nil
    }
    
    func numberOfComments() -> Int {
        return 0
    }
    
    func numberOfCommentsForPhotoExceeds(number: Int) -> Bool {
        return true
    }

    func viewAllCommentsAttributedString() -> NSAttributedString {
        return NSAttributedString()
    }
    
    func requestPage(with completion: (([CommentModel]) -> Void)) {
        
    }
    
    func refreshFeed(with completion: (([CommentModel]) -> Void)) {
        
    }
}
