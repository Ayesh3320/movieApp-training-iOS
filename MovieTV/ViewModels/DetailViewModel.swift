//
//  DetailViewModel.swift
//  MovieTV
//
//  Created by Syed Ayesh on 19/04/2023.
//

import Foundation
class DetailViewModel{
    
    public var movieDetail = MovieDetailModel()
    
//    public struct genre: Codable {
//        var genre_name: String
//        var id: Int32
//    }
    
    var genres: [MovieDetailModel.genre] = []
    
    public struct movie: Codable {
        var id: Int32
        var title: String
        var overview: String
        var vote_average: Float32
        var poster_path: String
        var genres: [MovieDetailModel.genre]
        var runtime: Int32
    }
    
    private let networkService: NetworkService = DefaultNetworkService()
    
    func fetchMovieDetail(id:String, _ completion: @escaping (_ success: Bool, _ data:MovieDetailModel?) -> Void) {
        
        networkService.get(endpoint: "/3/movie/"+id+"?api_key=c7a894ee0161b530c3244385f327998c&language=en-US"){
            success, result in
            if(success){
                do {
                    
                    let jsonResponse = try JSONDecoder().decode(movie.self, from:result!)
                    print(jsonResponse)
                    for genreResp in jsonResponse.genres{
                        var k = MovieDetailModel.genre(name: genreResp.name, id: genreResp.id)
                        self.genres.append(k)
                    }
                    
                    self.movieDetail.configure(id: jsonResponse.id, title: jsonResponse.title, overview: jsonResponse.overview, vote_average: jsonResponse.vote_average, poster_path: "https://image.tmdb.org/t/p/w500/"+jsonResponse.poster_path, genres: self.genres, runtime: jsonResponse.runtime)
                    completion(true, self.movieDetail)
  
                } catch let error {
                    print(error)
                    
                }
            }
        }
        
    }
    
    
}
