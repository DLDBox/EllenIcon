//
//  Types.swift
//  JobTest
//
//  Created by Dana Devoe on 5/13/17.
//  Copyright © 2017 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

typealias Closure                   = ( ) -> Void
typealias ClosureWithInt            = ( _ sequence: Int ) -> Void
typealias ClosureWithPayload        = ( _ payLoad: Payload ) -> Void
typealias ClosureWithStringAndImage = ( _ urlStrings: String ) -> UIImage?
typealias ClosureWithStrings        = ( _ urlStrings: [String] ) -> Void
typealias ClosureWithImage          = ( _ anImage: UIImage ) -> Void
typealias ClosureWithImageAndIndex  = ( _ anImage: UIImage,_ index: Int ) -> Void
typealias ClosureWithImageInfo      = ( _ imageInfo: ImageInfo ) -> Void
typealias ClosureWithError          = ( _ error: CloudFrontErrors ) -> Void
typealias jsonDictionary            = [String : AnyObject]

