//
//  MovieDetailModel.swift
//  MovieTV
//
//  Created by Syed Ayesh on 19/04/2023.
//

import Foundation

class MovieDetailModel {
    
    public struct genre: Codable {
        var name: String
        var id: Int32
    }
    
    var id: Int32
    var title: String
    var overview: String
    var vote_average: Float32
    var poster_path: String
    var genres: [genre]
    var runtime: Int32
    
    func configure(id:Int32, title: String, overview: String, vote_average: Float32, poster_path:String, genres: [genre], runtime: Int32) {
        self.id = id
        self.title = title
        self.overview = overview
        self.vote_average = vote_average
        self.poster_path = poster_path
        self.genres = genres
        self.runtime = runtime
    }
    
    init() {
        self.id = 0
        self.title = ""
        self.overview = ""
        self.vote_average = 0
        self.poster_path = ""
        self.genres = []
        self.runtime = 0
    }
    
}
