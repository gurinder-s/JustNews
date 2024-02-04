//
//  TopStoriesViewController.swift
//  JustNews
//
//  Created by G on 04/02/2024.
//

import UIKit

class TopStoriesViewController: UIViewController {
    
    //Collection View
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,NewsModel>!
    // Top Stories
    var topStories: [NewsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getTopStories()
        configureDataSource()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createOneColumnFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minItemSpacing:CGFloat = 10
        let availableWidth = width - (padding * 2) - (minItemSpacing * 2)
        let itemWidth = availableWidth
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getTopStories(){
        NetworkManager.shared.fetchTopStories(){ result in
            switch result{
            case .success(let newsresponse):
                print(newsresponse.data)
                self.topStories = newsresponse.data
                self.updateData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,NewsModel>(collectionView: collectionView, cellProvider: {(collectionView,indexPath, newsModel) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryViewCell.reuseID, for: indexPath) as! StoryViewCell
            cell.set(newsstory: newsModel)
            return cell
        })
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,NewsModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(topStories)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
            print(self.topStories.count)
        }
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createOneColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(StoryViewCell.self, forCellWithReuseIdentifier: StoryViewCell.reuseID)
    }
    
    
    
}
