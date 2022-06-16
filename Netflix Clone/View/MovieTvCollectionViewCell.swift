//
//  MovieTvCollectionViewCell.swift
//  Netflix Clone
//
//  Created by HAMZA on 15/6/2022.
//

import UIKit
import SDWebImage

class MovieTvCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieTvCollectionViewCell"
    
    private let posterImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImgView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImgView.frame = contentView.bounds
        
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        
        posterImgView.sd_setImage(with: url, completed: nil)
    }
    
}
