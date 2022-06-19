//
//  CollectionViewTableCell.swift
//  Netflix Clone
//
//  Created by HAMZA on 12/6/2022.
//

import UIKit

protocol CollectionViewTableCellDelegate: AnyObject {
    func CollectionViewTableCellClicked(_ cell: CollectionViewTableCell, viewModel: TitlePreviewViewModel)
}


class CollectionViewTableCell: UITableViewCell {

    static let identifier = "CollectionViewTableCell"
    
    weak var delegate: CollectionViewTableCellDelegate?
    
    private var titles: [MovieTv] = [MovieTv]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieTvCollectionViewCell.self, forCellWithReuseIdentifier: MovieTvCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles: [MovieTv]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitle(indexPath: IndexPath) {
        
        DataManager.shared.downloadTitle(with: titles[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}


extension CollectionViewTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTvCollectionViewCell.identifier, for: indexPath) as? MovieTvCollectionViewCell else {
            return UICollectionViewCell()
            
        }

        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
            
        }
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_name ?? title.original_title else { return }
        
        ApiManager.shared.getMovie(with: titleName + " trailer") { [weak self] result in
            
            switch result {
                
            case .success(let youtubeElement):
                let title = self?.titles[indexPath.row]
                guard let titleOverview = title?.overview else { return }
                
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeVideo: youtubeElement, titleOverView: titleOverview)
                
                guard let strongSelf = self else { return }
                self?.delegate?.CollectionViewTableCellClicked(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { [weak self] _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.downloadTitle(indexPath: indexPath)
                }
                return UIMenu(title: "", subtitle: nil, image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        return config
    }
    
}
