//
//  File.swift
//  JobTest
//
//  Created by Dana Devoe on 5/14/17.
//  Copyright © 2017 Dana Devoe. All rights reserved.
//

import Foundation

///
/// Encapsulates the Semphore object
///
class Semaphore {
    var sem: DispatchSemaphore
    var initialCount: Int
    var releaseCount: Int
    
    //MARK: - Initializer
    
    init(_ withCount: Int ) {
        sem = DispatchSemaphore( value: 0 )
        initialCount = withCount
        releaseCount = 0
    }
    
    //MARK: - Deinit
    
    deinit {
        releaseWait()
    }
    
    ///
    /// This function will block the current thread until the internal
    /// count recaches zero
    ///
    func waitUntilZero() {
        let result = sem.wait(timeout: DispatchTime.distantFuture)
        print( "\(result)" )
    }
    
    ///
    /// This function will wait until the supplied count is
    /// reached
    ///
    /// - Parameter count: The count to reach before releasing
    ///
    func waitUntil( count: Int ) {
        releaseCount = count
        let _ = sem.wait(timeout: DispatchTime.distantFuture)
    }
    
    //
    /// This method will release any waiting calls such as
    /// waitUntilZero() or waitUntil()
    ///
    func releaseWait(){
        sem.signal()
    }
    
    ///
    /// Increate the internal count value
    ///
    func increaseCount() {
        initialCount += 1
        
        if initialCount == self.releaseCount {
            releaseWait()
        }
    }
    
    ///
    /// Decrease teh internal count value
    ///
    func decreaseCount(){
        initialCount -= 1
        
        if initialCount == self.releaseCount {
            releaseWait()
        }
    }
}
