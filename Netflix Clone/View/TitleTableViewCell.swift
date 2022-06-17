//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by HAMZA on 16/6/2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playTitleBtn: UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "play.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titlePosterImg: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterImg)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleBtn)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let imageConstraints = [
            titlePosterImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterImg.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let labelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImg.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleBtn.leadingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let buttonConstraint = [
            playTitleBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playTitleBtn.widthAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(buttonConstraint)
    }
    
    public func configure(with model: TitleViewModel) {
    
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        
        titlePosterImg.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
