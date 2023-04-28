//
//  NetworkService.swift
//  MovieTV
//
//  Created by Syed Ayesh on 28/04/2023.
//

import Foundation

protocol NetworkService {
    
    var baseURL: String { get set }
    var body: Any? {get set}
    
    func get(endpoint: String,_ completion: @escaping (_ success: Bool, _ data:Data?) -> Void)
    
}

final class DefaultNetworkService: NetworkService {

    var baseURL: String = "https://api.themoviedb.org"
    
    var body: Any? = nil
    
    func get(endpoint: String, _ completion: @escaping (Bool,Data?) -> Void) {
        var request = URLRequest(url: URL(string: baseURL+endpoint)!,timeoutInterval: Double.infinity)
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
            
            completion(true,responseData)
        }
        
        task.resume()
    }
    
    
    
}
