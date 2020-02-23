
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tweet = try? newJSONDecoder().decode(Tweet.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.tweetTask(with: url) { tweet, response, error in
//     if let tweet = tweet {
//       ...
//     }
//   }
//   task.resume()

import Foundation

struct Tweets : Codable{
    var statuses : [Status]
}

struct Status : Codable {
    let text : String
    let id_str :String
    let user : User
    let created_at : Date
    let favorite_count : Int
    let retweet_count : Int
}

struct User : Codable {
    let id_str : String
    let name : String
    let screen_name : String
    let profile_image_url : String
    let verified : Bool
}

struct ExtendEntities : Codable{
    let medias : [Media]?
    
}

struct Media : Codable {
    let media_url_https : String?
    let type : String?
    let sizes : [Size]?
    
}

struct Size : Codable {
    let w: Int
    let h: Int
    let resize: String
}

struct TweetURL : Codable {
    let display_url : String?
    let expanded_url : String?
    let indices : [Int]?
    let url : String?
}
