//
//  CloudFrontService.swift
//  JobTest
//
//  Created by Dana Devoe on 5/11/17.
//  Copyright © 2017 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

class CloudFrontService {
    
    ///
    /// Returns the array of URL which point to images to be loaded
    ///
    /// - Parameter urlString: The payload URL
    class func getPayLoad( urlString: String,success: @escaping ClosureWithPayload, failure: @escaping ClosureWithError ) {
        
        if let url = URL( string: urlString ) {
            
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: urlRequest, completionHandler: { (data,response,error) in
                
                if error != nil {
                    failure( .noData )
                    
                } else if let data = data {
                    
                    guard let payload = (try? JSONSerialization.jsonObject(with: data, options: []) as? jsonDictionary)  else {
                        print("error trying to convert data to JSON")
                        return
                    }
                    
                    if let payload = payload {
                        success( Payload(json: payload) )
                    } else {
                        failure( .noData )
                    }
                    
                } else {
                    failure( .noData )
                }
            })
            
            task.resume()
            
        } else {
            failure( .unknown )
        }
    }
    
    /// loads one image at a time
    ///
    /// - Parameters:
    ///   - urlString: The URL as a string
    ///   - success: Called when successful loading image at the URL specified
    ///   - failure: Called once their is an error
    ///
    class func retreiveImages( urlString: String,success: @escaping ClosureWithImage, failure: @escaping ClosureWithError  ) {
        
        if let url = URL( string: urlString ) {
            
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: urlRequest, completionHandler: { (data,response,error) in
                
                if let data = data {
                    
                    if let image: UIImage = UIImage(data:data, scale:1.0) {
                        success( image )
                    } else {
                        failure( .noData )
                    }
                    
                } else {
                    failure( .noData )
                }
                
            })
            
            task.resume()
        }
    }

}

