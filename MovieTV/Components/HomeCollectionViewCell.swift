//
//  HomeCollectionViewCell.swift
//  MovieTV
//
//  Created by Syed Ayesh on 18/04/2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "HomeCollectionViewCell"
    
    public let bgImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    public let movieName: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        return label
    }()
    
    public let rating: UILabel = {
        
        let stars = UILabel()
        stars.textColor = .black
        stars.textAlignment = .left
        stars.translatesAutoresizingMaskIntoConstraints = false
        stars.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        stars.textColor = UIColor.systemOrange
        return stars
    }()
    
    
    
    
    
    
    // Mark  -  Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        contentView.backgroundColor = .purple
        //        contentView.addSubview(bgImage)
        //        contentView.addSubview(movieName)
        //        contentView.addSubview(rating)
        
        let stackView = UIStackView(arrangedSubviews: [ bgImage,movieName, rating])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .white
                stackView.spacing = 5
        
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            bgImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
//            bgImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            movieName.topAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: 30),
            movieName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            rating.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            rating.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 10),
            //                    rating.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
        
//        stackView.layer.shadowColor = UIColor.black.cgColor
//        stackView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        stackView.layer.shadowOpacity = 0.4
//        stackView.layer.shadowRadius = 5
        
        //        loadImage(from: <#T##URL#>)
        
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.bgImage.image = UIImage(data: data)
            }
        }.resume()
    }
    
    func configure(data: MovieModel){
        loadImage(from: data.poster_path)
        movieName.text = data.title
        rating.text = String(data.vote_average)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        bgImage.frame = contentView.bounds
        //        movieName.frame = contentView.bounds
        //        rating.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
