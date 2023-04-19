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
    
    func fetchMovieDetail(id:String, _ completion: @escaping (_ success: Bool, _ data:MovieDetailModel?) -> Void) {
        
        
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/"+id+"?api_key=c7a894ee0161b530c3244385f327998c&language=en-US")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                completion(false, nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                print("Invalid Response received from the server")
                completion(false, nil)
                return
            }
            
            guard let responseData = data else {
                print(String(describing: error))
                completion(false, nil)
                return
            }
            
            do {
                
                let jsonResponse = try JSONDecoder().decode(movie.self, from:responseData)
                print(jsonResponse)
                for genreResp in jsonResponse.genres{
                    var k = MovieDetailModel.genre(name: genreResp.name, id: genreResp.id)
                    self.genres.append(k)
                }
                
                self.movieDetail.configure(id: jsonResponse.id, title: jsonResponse.title, overview: jsonResponse.overview, vote_average: jsonResponse.vote_average, poster_path: "https://image.tmdb.org/t/p/w500/"+jsonResponse.poster_path, genres: self.genres, runtime: jsonResponse.runtime)
                completion(true, self.movieDetail)
                //                for movie in jsonResponse.results{
                //                    self.moviesList.append(MovieModel(id: movie.id, title: movie.title, vote_average: movie.vote_average, poster_path: "https://image.tmdb.org/t/p/w500/"+movie.poster_path))
                //                    print("https://image.tmdb.org/t/p/w500/"+movie.poster_path+"\n")
                //                    completion(true)
                //                }
                //                DispatchQueue.main.async {
                //                    self.tableview.reloadData()
                //                }
                
            } catch let error {
                print(error)
                
            }
            
        }
        
        task.resume()
    }
    
    
}
