//
//  TestingViewController.swift
//  Twrendings
//
//  Created by 徐承維 on 2020/2/22.
//  Copyright © 2020 徐承維. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        testGetImage(urlStr: "https://pbs.twimg.com/media/Cc9FyscUkAEQaOw.jpg")
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func testGetImage(urlStr : String){
        let request = URLRequest(url: URL(string: urlStr)!, timeoutInterval: Double.infinity)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}
