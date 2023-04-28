//
//  HomeTableCellViewModel.swift
//  MovieTV
//
//  Created by Syed Ayesh on 18/04/2023.
//

import Foundation

class HomeTableCellViewModel{
    
    public var moviesList: [MovieModel] = []
    
    private let networkService: NetworkService = DefaultNetworkService()
    
    func fetchMovies(_ completion: @escaping (_ success: Bool) -> Void) {
        
        networkService.get(endpoint:"/3/discover/movie?api_key=c7a894ee0161b530c3244385f327998c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"){ success, result in
            
            if(success){
                do {
                    
                    let jsonResponse = try JSONDecoder().decode(movieListResponse.self, from:result!)
                    print(jsonResponse)
                    for movie in jsonResponse.results{
                        self.moviesList.append(MovieModel(id: movie.id, title: movie.title, vote_average: movie.vote_average, poster_path: "https://image.tmdb.org/t/p/w500/"+movie.poster_path))
                        print("https://image.tmdb.org/t/p/w500/"+movie.poster_path+"\n")
                        
                    }
                    completion(true)
                    
                } catch let error {
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
}


