//
//  PhotoViewController.swift
//  CollectionViewDemo
//
//  Created by SHIH-YING PAN on 2020/1/20.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photoName: String?

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photoName = photoName {
            imageView.image = UIImage(named: photoName)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
