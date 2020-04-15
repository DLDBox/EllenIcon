//
//  File.swift
//  JobTest
//
//  Created by Dana Devoe on 5/13/17.
//  Copyright © 2017 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit


class CloudFrontManager {
    
    ///MARK: Private members
    var payLoad: Payload?
    
    ///
    /// Returns the number of ImageInfo objects held by the payload object
    ///
    var count: Int {
        get {
            if let payLoad = payLoad {
                return payLoad.count
            }
            return 0
        }
    }
    
    /// MARK: - Public functions
    
    /// Start the download in the background
    /// more optimization can be done here, so that unnecessary update are not made, etc
    //
    /// - Parameter complete: The closure which is called to update UI
    func startDownload( complete: @escaping Closure ) {
        
        CloudFrontService.getPayLoad( urlString: urls.images.payload, success: {(payloadData) in
            
            self.payLoad = payloadData
            self.backgroundDownload( progress: {
                
                DispatchQueue.main.async {
                    complete()
                }
                
            })
            
        }, failure: { (error) in
            print( "Error loading payload \(error)" )
        })
        
    }

    ///
    /// return the imageinfo at the given index
    ///
    /// - Parameter index: The index to retreive
    subscript(index: Int) -> ImageInfo? {
        
        if let payLoad = payLoad {
            return payLoad[index]
        }
        return nil
    }
    
    //MARK: - background operation
    
    /// The background worker function
    ///
    /// - Parameter progress: The closure used for updating the UI
    fileprivate func backgroundDownload( progress: @escaping Closure  ) {
        
        if let payLoad = payLoad {
            
            var sem = Semaphore(15)
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 15
            
            for index in 0..<payLoad.count{
                
                queue.addOperation {
                    
                    CloudFrontService.retreiveImages(urlString: payLoad.imageInfos[index].url, success:{(image) in
                        payLoad.imageInfos[index].image = image
                        
                        progress()
                        sem.decreaseCount()
                        
                    },failure:{(image) in
                        print( "Error loading and image" )
                    })
                }
                
                if index != 0 && index % 15 == 0 {
                    sem.waitUntilZero()
                    sem = Semaphore(15)
                }
            }
        }
    }
    
}
