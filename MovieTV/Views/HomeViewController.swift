//
//  ViewController.swift
//  MovieTV
//
//  Created by Syed Ayesh on 18/04/2023.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var  carousel: UICollectionView!
    @IBOutlet var carouselContainer: UIView!
    let activityView = UIActivityIndicatorView(style: .large)
    
    let moviesModel = HomeTableCellViewModel()
    
    var loaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicatory()
        carousel.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        carousel.dataSource = self
        carousel.delegate = self
        carousel.frame = view.bounds
        carouselContainer.addSubview(carousel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.moviesModel.fetchMovies{ success in
                self.hideActivityIndicator()
                if(success && !self.loaded){
                    DispatchQueue.main.async {
                        self.carousel.reloadData()
                        self.loaded = true
                    }
                }else{
                    
                }
                
            }
        }
        
        
        
        
    }
    
    
    // Mark  -  Activity Indicator
    
    func showActivityIndicatory() {
        
        activityView.center = self.view.center
        activityView.color = .purple
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            DispatchQueue.main.async {
                self.activityView.stopAnimating()
            }
        }
    }
    
    // Mark  -  ImageView
    
    
    
    // Mark  -  Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesModel.moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width * 0.4
        let height = view.frame.size.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            // Set any data you want to pass to the destination view controller here
            // For example:
        detailViewController.data = moviesModel.moviesList[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    // Mark  -  Data Sources
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath)
                as? HomeCollectionViewCell else {
            fatalError()
        }
        //        var k: MovieModel = MovieModel(name: "ABc", rating: "5", image: "4")
        cell.configure(data: moviesModel.moviesList[indexPath.row])
        return cell
    }
    
    
    
}

