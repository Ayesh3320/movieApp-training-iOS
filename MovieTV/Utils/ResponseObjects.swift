//
//  MovieList.swift
//  MovieTV
//
//  Created by Syed Ayesh on 28/04/2023.
//

import Foundation

public struct movieListResponse:Codable {
    var results: [MovieModel]
    var page: Int32
}

