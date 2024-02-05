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
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getTopStories(page: page)
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
    
    func getTopStories(page: Int){
        NetworkManager.shared.fetchTopStories(page: page){ [weak self] result in
            switch result{
            case .success(let newsresponse):
                print(newsresponse.data)
                self?.topStories.append(contentsOf: newsresponse.data)
                self?.updateData()
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
        collectionView.delegate = self
    }
    
    
    
}

extension TopStoriesViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get the tapped news story
        let story = topStories[indexPath.row]
        let storyId = story.uuid
        print("Selected story: \(story.title)")
        let newsStoryVC = NewsStoryViewController()
        //present(newsStoryVC, animated: true)
        navigationController?.pushViewController(newsStoryVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight-height{
            page += 1
            getTopStories(page: page)
        }
    }
    
}
