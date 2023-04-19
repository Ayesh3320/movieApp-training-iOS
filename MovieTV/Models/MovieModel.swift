//
//  MovieModel.swift
//  MovieTV
//
//  Created by Syed Ayesh on 19/04/2023.
//

import Foundation

class MovieModel{
    
    var id: Int32
    var title: String
    var vote_average: Float32
    var poster_path: String
    
    init(id:Int32, title: String, vote_average: Float32, poster_path:String) {
        self.id = id
        self.title = title
        self.vote_average = vote_average
        self.poster_path = poster_path
    }
    
    
}
