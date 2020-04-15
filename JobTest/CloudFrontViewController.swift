//
//  File.swift
//  JobTest
//
//  Created by Dana Devoe on 5/14/17.
//  Copyright © 2017 Dana Devoe. All rights reserved.
//

import Foundation
import UIKit

///
/// The Collection View of Images
///
class CloudFrontViewController: UIViewController {
    
    var gridCollectionView: UICollectionView!
    var gridLayout: CloudFrontLayout!
    var fullImageView: UIImageView!
    
    var cloudFrontManager = CloudFrontManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridLayout = CloudFrontLayout()
        
        gridCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: gridLayout)
        gridCollectionView.backgroundColor                  = color.backgroundColor
        gridCollectionView.showsVerticalScrollIndicator     = false
        gridCollectionView.showsHorizontalScrollIndicator   = false
        gridCollectionView.dataSource                       = self
        gridCollectionView.delegate                         = self
        
        gridCollectionView!.register(CloudFrontCell.self, forCellWithReuseIdentifier: ID.collectCell )
        self.view.addSubview(gridCollectionView)
        
        fullImageView                           = UIImageView()
        fullImageView.contentMode               = .scaleAspectFit
        fullImageView.backgroundColor           = UIColor.lightGray
        fullImageView.isUserInteractionEnabled  = true
        fullImageView.alpha                     = 0
        self.view.addSubview(fullImageView)
        
        let dismissWihtTap = UITapGestureRecognizer(target: self, action: #selector(hideFullImage))
        fullImageView.addGestureRecognizer(dismissWihtTap)
        
        cloudFrontManager.startDownload(complete: {            
            self.gridCollectionView.reloadData()
        })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var frame                = gridCollectionView.frame
        frame.size.height        = self.view.frame.size.height
        frame.size.width         = self.view.frame.size.width
        frame.origin.x           = 0
        frame.origin.y           = 0
        gridCollectionView.frame = frame
        fullImageView.frame      = gridCollectionView.frame
    }
    
    /// Show the images which are in the grid
    ///
    /// - Parameter image: The image to display
    ///
    func showFullImage(of image:UIImage) {
        
        fullImageView.transform     = CGAffineTransform(scaleX: 0, y: 0)
        fullImageView.contentMode   = .scaleAspectFit
        
        UIView.animate(withDuration: timing.animationlen, delay: timing.delay, options: [], animations:{[unowned self] in
            
            self.fullImageView.image = image
            self.fullImageView.alpha = 1
            self.fullImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            }, completion: nil)
    }
    
    ///
    /// hide image being displayed
    ///
    @objc func hideFullImage() {
        
        UIView.animate(withDuration: timing.animationlen, delay:timing.delay, options: [], animations:{[unowned self] in
            self.fullImageView.alpha = 0
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CloudFrontViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cloudFrontManager.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID.collectCell, for: indexPath) as! CloudFrontCell
        cell.backgroundColor = UIColor.blue
        cell.imageView.image = self.cloudFrontManager[indexPath.row]?.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CloudFrontCell
        
        if let image = cell.imageView.image {
            self.showFullImage(of: image)
        } else {
            print("no photo")
        }
    }
    
}
