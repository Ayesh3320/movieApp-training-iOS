//
//  HomeControllerModel.swift
//  MovieTV
//
//  Created by Syed Ayesh on 19/04/2023.
//

import Foundation

func fetchMovies(_ completion: @escaping (_ success: Bool, _ data: Data?) -> Void) {

    var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=c7a894ee0161b530c3244385f327998c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")!,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            completion(false, nil)
            return
        }
        completion(true,data)
        print(String(data: data, encoding: .utf8)!)
    }
    
    task.resume()
    
}
