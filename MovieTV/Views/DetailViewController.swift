//
//  DetailViewController.swift
//  MovieTV
//
//  Created by Syed Ayesh on 19/04/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var data: MovieModel?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var rating: UILabel!
    @IBOutlet var movie_name: UILabel!
    @IBOutlet var genres: UILabel!
    @IBOutlet var overview: UILabel!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet weak var backButton1: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    let activityView = UIActivityIndicatorView(style: .large)
    var movieDetail = DetailViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        rating.text = ""
        movie_name.text = ""
        genres.text = ""
        overview.text = ""
        navigationItem.hidesBackButton = true
        loadImage(from: data!.poster_path)
        imageView.isUserInteractionEnabled = true
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 50
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        showActivityIndicatory()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.movieDetail.fetchMovieDetail(id: String(self.data!.id)){ success, data in
                if(success){
                    DispatchQueue.main.async{
                        self.rating.text = (String(format: "%.1f", self.movieDetail.movieDetail.vote_average!))+"/10"
                        self.movie_name.text = self.movieDetail.movieDetail.title
                        let names = self.movieDetail.genres.map { $0.name }
                        self.genres.text = names.joined(separator: "/")
                        
                        self.overview.text = self.movieDetail.movieDetail.overview
                    }
                }
                self.hideActivityIndicator()
            }
        }
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    @IBAction func backTapped()
    {
        navigationController?.popViewController(animated: true)
    }
    
    
    // Mark  -  Activity Indicator
    
    func showActivityIndicatory() {
        indicator.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (indicator != nil){
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
