//
//  CloudFrontLayout.swift
//  JobTest
//
//  Created by Dana Devoe on 5/14/17.
//  Copyright © 2017 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

class CloudFrontLayout: UICollectionViewFlowLayout {
    
    let innerSpace:         CGFloat = 5.0
    let numberOfCellsOnRow: CGFloat = 4
    
    ///
    /// The initialize
    ///
    override init() {
        super.init()
        
        self.minimumLineSpacing         = innerSpace
        self.minimumInteritemSpacing    = innerSpace
        self.scrollDirection            = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    ///
    /// The items width eturns the full width divided but how many cells 
    /// in a “row” you want, minus the amount of the Innerspace.
    ///
    /// - Returns: <#return value description#>
    ///
    func itemWidth() -> CGFloat {
        
        if let collectionView = collectionView {
            
            return (collectionView.frame.size.width/self.numberOfCellsOnRow)-self.innerSpace
        }
        return 0
    }
    
    //
    /// Setup the size of the cells in the grid
    ///
    override var itemSize: CGSize {
        
        set {
            self.itemSize = CGSize(width:itemWidth(), height:itemWidth())
        }
        get {
            return CGSize(width:itemWidth(),height:itemWidth())
        }
    }

}
