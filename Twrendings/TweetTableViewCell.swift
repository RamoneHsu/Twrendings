//
//  TweetTableViewCell.swift
//  Twrendings
//
//  Created by 徐承維 on 2020/2/21.
//  Copyright © 2020 徐承維. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var verifiedImageView: UIImageView!
    
    func update (status: Status){
        let dateFormat = DateFormatter()
               dateFormat.dateFormat = "a h:mm · yyyy年MM月dd日"
        
        indicator.isHidden = true
        let user = status.user
        nameLabel.text = user.name
        screenNameLabel.text = "@" + user.screen_name
        likeCountLabel.text = status.favorite_count.description
        retweetCount.text = status.retweet_count.description
        dateLabel.text = dateFormat.string(from: status.created_at)
        contentTextView.text = status.text
        
        if !user.verified {
            verifiedImageView.isHidden = true
        } else {
            verifiedImageView.isHidden = false
        }
        
        
            getPersonImage(urlStr: user.profile_image_url, cell : self)
            
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        personImageView.image = UIImage.init(systemName: "person.circle")
//    }
    
    func getPersonImage(urlStr : String, cell: TweetTableViewCell) {
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) { (data, response, erro) in
                if let data = data, let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        cell.personImageView.image = image
                        cell.personImageView.layer.cornerRadius = CGFloat(25)
                        cell.reloadInputViews()
                    }
                }
            }.resume()
        }
    }
    

}
