//
//  HeroHeaderView.swift
//  Netflix Clone
//
//  Created by HAMZA on 13/6/2022.
//

import UIKit

class HeroHeaderView: UIView {
    
    private let downloadBtn: UIButton = {
       let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let playBtn: UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let HeroImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(HeroImgView)
        addGradient()
        addSubview(playBtn)
        addSubview(downloadBtn)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let playBtnConstraints = [
            playBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            playBtn.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let downloadBtnConstraints = [
            downloadBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -70),
            downloadBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            downloadBtn.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(playBtnConstraints)
        NSLayoutConstraint.activate(downloadBtnConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        HeroImgView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
