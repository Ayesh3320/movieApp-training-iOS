//
//  MovieModel.swift
//  MovieTV
//
//  Created by Syed Ayesh on 19/04/2023.
//

import Foundation

struct MovieModel: Codable{
    
    var id: Int32
    var title: String
    var vote_average: Float32
    var poster_path: String
}
