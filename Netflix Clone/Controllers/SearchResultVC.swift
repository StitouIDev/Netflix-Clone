//
//  SearchResultVC.swift
//  Netflix Clone
//
//  Created by HAMZA on 17/6/2022.
//

import UIKit

protocol SearchResultVCDelegate: AnyObject {
    func searchResultVcClickedItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultVC: UIViewController {
    
    public var titles: [MovieTv] = [MovieTv]()
    
    public weak var delegate: SearchResultVCDelegate?

    
    public let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieTvCollectionViewCell.self, forCellWithReuseIdentifier: MovieTvCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
        
        
    }
}


extension SearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTvCollectionViewCell.identifier, for: indexPath) as? MovieTvCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        ApiManager.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let youtubeElement):
                self?.delegate?.searchResultVcClickedItem(TitlePreviewViewModel(title: titleName, youtubeVideo: youtubeElement, titleOverView: title.overview ?? ""))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
}
