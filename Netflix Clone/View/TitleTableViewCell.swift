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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playTitleBtn: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titlePosterImg: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
            titlePosterImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlePosterImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titlePosterImg.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let labelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImg.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: model.posterURL) else { return }
        titlePosterImg.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
