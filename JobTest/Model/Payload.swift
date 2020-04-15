//
//  File.swift
//  JobTest
//
//  Created by Dana Devoe on 5/13/17.
//  Copyright © 2017 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

struct ImageInfo {
    let url: String
    var image: UIImage?
}

///
/// This object is designed to decode the JSON payload read from the server
///
class Payload {
    
    /// MARK: Private members
    var imageInfos: [ImageInfo]
    
    ///MARK: - Initializer
    
    /// 
    /// Initializer
    ///
    /// - Parameter json: The json to parse
    init( json: jsonDictionary ) {
        
        if let assets = json[jsonDef.assets] as? [Any] {
            
            let placeholder = UIImage( named: images.placeholder )
            var urlArray = [ImageInfo]()
            
            assets.forEach( {(asset) in
                
                if let asset = asset as? [String : Any], let urlString = asset[jsonDef.url] as? String {
                    urlArray.append( ImageInfo(url:urlString,image: placeholder) )
                }
            })
            
            self.imageInfos = urlArray
        } else {
            self.imageInfos = []
        }
    }
    
    /// MARK: getters/setters
    
    ///
    /// Returns the number of urls in the internal store
    ///
    var count: Int {
        get {
            return imageInfos.count
        }
    }
    
    ///
    /// Returns a URL at the given index
    ///
    /// - Parameter index: index to return
    ///
    subscript(index: Int) -> ImageInfo? {
        if index < count {
            return imageInfos[index]
        }
        assert(false, "index out of range")
        return nil
    }
    
    ///
    /// Used to loop through the internal image storage - maintain data encapusation
    ///
    /// - Parameter handler: The closure to Receive the imageinfo
    ///
    func forEach( handler: @escaping ClosureWithImageInfo ) {

        imageInfos.forEach( {(imageInfo) in
            handler(imageInfo)
        })
    }
    
}
