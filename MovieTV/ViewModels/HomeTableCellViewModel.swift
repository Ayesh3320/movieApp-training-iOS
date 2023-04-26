//
//  HomeTableCellViewModel.swift
//  MovieTV
//
//  Created by Syed Ayesh on 18/04/2023.
//

import Foundation

class HomeTableCellViewModel{
    
    public var moviesList: [MovieModel] = []
    
    public struct movie: Codable {
        var id: Int32
        var title: String
        var vote_average: Float32
        var poster_path: String
    }
    
    public struct tmpStruct:Codable {
        var results: [movie]
        var page: Int32
    }
    
    func fetchMovies(_ completion: @escaping (_ success: Bool) -> Void) {
        
        
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=c7a894ee0161b530c3244385f327998c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                print("Invalid Response received from the server")
                completion(false)
                return
            }
            
            guard let responseData = data else {
                print(String(describing: error))
                completion(false)
                return
            }
            
            do {
                
                let jsonResponse = try JSONDecoder().decode(tmpStruct.self, from:responseData)
                print(jsonResponse)
                for movie in jsonResponse.results{
                    self.moviesList.append(MovieModel(id: movie.id, title: movie.title, vote_average: movie.vote_average, poster_path: "https://image.tmdb.org/t/p/w500/"+movie.poster_path))
                    print("https://image.tmdb.org/t/p/w500/"+movie.poster_path+"\n")
                    
                }
                completion(true)
                //                DispatchQueue.main.async {
                //                    self.tableview.reloadData()
                //                }
                
            } catch let error {
                print(error.localizedDescription)
                
            }
            
        }
        
        task.resume()
    }
}


