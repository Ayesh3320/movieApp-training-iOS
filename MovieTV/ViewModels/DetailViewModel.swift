//
//  DetailViewModel.swift
//  MovieTV
//
//  Created by Syed Ayesh on 19/04/2023.
//

import Foundation
class DetailViewModel{
    
    public var movieDetail = MovieDetailModel()
    var genres: [genre] = []
    private let networkService: NetworkService = DefaultNetworkService()
    
    func fetchMovieDetail(id:String, _ completion: @escaping (_ success: Bool, _ data:MovieDetailModel?) -> Void) {
        
        networkService.get(endpoint: "/3/movie/"+id+"?api_key=c7a894ee0161b530c3244385f327998c&language=en-US"){
            success, result in
            if(success){
                do {
                    let jsonResponse = try JSONDecoder().decode(MovieDetailModel.self, from:result!)
                    print(jsonResponse)
                    for genreResp in jsonResponse.genres ?? [] {
                        let k = genre(name: genreResp.name, id: genreResp.id)
                        self.genres.append(k)
                    }
                    
                    self.movieDetail = jsonResponse
                    completion(true, self.movieDetail)
  
                } catch let error {
                    print(error)
                    
                }
            }
        }
        
    }
    
    
}
