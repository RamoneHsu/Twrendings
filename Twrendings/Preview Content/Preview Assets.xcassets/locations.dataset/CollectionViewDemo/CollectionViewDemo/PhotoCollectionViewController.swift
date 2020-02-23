//
//  PhotoCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by SHIH-YING PAN on 2020/1/20.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionViewController: UICollectionViewController {
    
    var albums = [Album(name: "Ugly Beauty", singer: "蔡依林", imageName: "pic0"), Album(name: "愛的練習語", singer: "蔡依林", imageName: "pic1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (collectionView.bounds.width - 10 * 2) / 2
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: width, height: width + 60)
        layout?.estimatedItemSize = .zero
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let item = collectionView.indexPathsForSelectedItems![0].item
        let controller = segue.destination as! PhotoViewController
        controller.photoName = "pic\(item)"
        
        if let item = collectionView.indexPathsForSelectedItems?.first?.item, let controller = segue.destination as? PhotoViewController {
            
            controller.photoName = "pic\(item)"
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return albums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        let album = albums[indexPath.item]
        
        cell.imageView.image = UIImage(named: album.imageName)
        cell.albumLabel.text = album.name
        cell.singerLabel.text = album.singer
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
