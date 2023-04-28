//
//  MovieDetailModel.swift
//  MovieTV
//
//  Created by Syed Ayesh on 19/04/2023.
//

import Foundation

public struct genre: Codable {
    var name: String
    var id: Int32
}

struct MovieDetailModel: Codable {
    var id: Int32?
    var title: String?
    var overview: String?
    var vote_average: Float32?
    var poster_path: String?
    var genres: [genre]?
    var runtime: Int32?

}
