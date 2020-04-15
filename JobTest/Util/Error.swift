//
//  Error.swift
//  JobTest
//
//  Created by Dana Devoe on 5/12/17.
//  Copyright © 2017 Dana Devoe. All rights reserved.
//

import Foundation

enum CloudFrontErrors: Error {
    case unknown
    case notFound
    case timedOut
    case connectionError(value: Int)
    case serverUnavailable
    case noData
    case invalidRequest
    case invalidCredentials
    
    func netError( _ errorCode: Int ) -> CloudFrontErrors {
        
        switch errorCode {
        case 400:
            return .invalidRequest
        case 401:
            return .invalidCredentials
        case 404:
            return .notFound
        default:
            return .unknown
        }
    }
}
