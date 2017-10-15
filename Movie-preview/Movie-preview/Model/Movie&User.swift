//
//  Movie&User.swift
//  Movie-preview
//
//  Created by Yveslym on 10/14/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation

struct Movie: Codable{
    var title : String
    var id :Int
    var overview: String
    var originalTitle: String
    var releaseDate: String
    var posterPath: String
    var user: String?
    var imageBaseLink = "https://image.tmdb.org/t/p/w500"
    var voteAverage: Double
   
    init() {
        
         title  = ""
         id  = 0
         overview = ""
         originalTitle = ""
         releaseDate = ""
         posterPath = ""
        user = ""
         imageBaseLink = ""
         voteAverage = 0.0
    }
   
    
    enum CodingKeys:String,CodingKey {
        case results
        
        enum Results:String,CodingKey {
            case title
            case id
            case overview
            case originalTile = "original_title"
            case releaseDate = "release_date"
            case posterPath = "poster_path"
            case user
            case vote_average
        }
    }
    init(from decoder: Decoder)throws {
        
        
         let contenaire = try decoder.container(keyedBy:CodingKeys.self)
         var ContenaireResults = try contenaire.nestedUnkeyedContainer(forKey: .results)
         let results = try ContenaireResults.nestedContainer(keyedBy: CodingKeys.Results.self)
         id = (try results.decodeIfPresent(Int.self, forKey: .id)!)
        user = (try results.decodeIfPresent(String.self, forKey: .user))
         title = (try results.decodeIfPresent(String.self, forKey: .title)!)
         overview = (try results.decodeIfPresent(String.self, forKey: .overview)!)
          posterPath = (try results.decodeIfPresent(String.self, forKey: .posterPath)!)
         releaseDate = (try results.decodeIfPresent(String.self, forKey: .releaseDate)!)
         originalTitle = (try results.decodeIfPresent(String.self, forKey: .originalTile)!)
        voteAverage = (try results.decodeIfPresent(Double.self, forKey: .vote_average)!)
         imageBaseLink = imageBaseLink+posterPath
    }
    
    func encode(to encoder: Encoder) throws {
        var contenaire =  encoder.container(keyedBy: CodingKeys.self)
        var contenaireResult = contenaire.nestedUnkeyedContainer(forKey: .results)
        var results = contenaireResult.nestedContainer(keyedBy: CodingKeys.Results.self)
        try results.encode(id, forKey: .id)
        try results.encode(title,forKey: .title)
        try results.encode(overview,forKey: .overview)
        try results.encode(releaseDate,forKey: .releaseDate)
        try results.encode(originalTitle,forKey: .originalTile)
        try results.encode(posterPath, forKey: .posterPath)
        try results.encode(user, forKey: .user)
        try results.encode(voteAverage,forKey: .vote_average)
    }
}

//==> Mark setup the image query, geting the

//struct moviePoster: Codable {
//    var secureBaseUrl : String
//    var posterSize: [String]
//
//    enum codingkeys: String,CodingKey {
//        case poster_sizes
//        case secure_base_url
//    }
//        init(from decoder: Decoder)throws{
//            let contenaire = try decoder.container(keyedBy: codingkeys.self)
//            secureBaseUrl = (try contenaire.decodeIfPresent(String.self, forKey: .secure_base_url)!)
//            posterSize = (try contenaire.decodeIfPresent([String].self, forKey: .poster_sizes)!)
//        }
//    }






//extension Movie{
//    static func decodeMovie ()->[Movie]{
//        //if Users.currentUser != nil{
//        //fetch movie from database
//        }
//}

class Users: Codable{
    static var currentUser : Users?
    var firstName: String
    var lastName: String
    let email: String
    let password: String
    var favoriteMovie: [Movie]
    var userName: String
    var userToken : String
    
    init() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.password = ""
        self.favoriteMovie = []
        self.userName = ""
        self.userToken = ""
    }
    
    enum codingKeys: String,CodingKey {
        case first_name
        case last_name
        case email
        case user_name
        case Password
        case user_token
    }
    
    required init(from decoder: Decoder)throws {
        let contenaire = try decoder.container(keyedBy: codingKeys.self)
        self.firstName = (try contenaire.decodeIfPresent(String.self, forKey: .first_name)!)
        self.lastName = (try contenaire.decodeIfPresent(String.self, forKey: .last_name)!)
        self.email =  (try contenaire.decodeIfPresent(String.self, forKey: .email)!)
        self.userName =  (try contenaire.decodeIfPresent(String.self, forKey: .user_name)!)
        self.password = ""
        self.userToken =  (try contenaire.decodeIfPresent(String.self, forKey: .user_token)!)
        self.favoriteMovie = []
        Network.fetcMovies(completion: {movie in
            self.favoriteMovie.append(movie!)
        })
    }
}



struct Errors: Decodable{
    var error:String
    
    enum errorKey:String, CodingKey {
        case error
    }
    init(from decoder:Decoder)throws {
        let contenaire = try decoder.container(keyedBy: errorKey.self)
        error = (try contenaire.decodeIfPresent(String.self, forKey: .error))!
    }
}






















