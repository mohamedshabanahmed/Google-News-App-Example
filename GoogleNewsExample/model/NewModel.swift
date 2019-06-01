//
//  NewModel.swift
//  GoogleNewsExample
//
//  Created by MAC on 5/22/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class NewModel: NSObject {
    
    var author : String?
    var title : String?
    var descriptiontext : String?
    var url : String?
    var urlToImage : String?
    var  publishedAt : String?
    var content : String?
    
    init(author : String , title : String , descriptiontext : String , url : String , urlToImage : String , publishedAt : String , content : String ) {
        
        self.author = author
        self.title = title
        self.descriptiontext = descriptiontext
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        
    }
}
