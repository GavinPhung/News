//
//  ViewController.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupNavigationBar()
        setUpCollectionView()
        
        viewModel.onViewDidLoad()
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Colors.background.color
        collectionView.register(UINib(nibName: "NewsArticleCell", bundle: nil), forCellWithReuseIdentifier: "NewsArticleCell")
        collectionView.register(UINib(nibName: "HeadlineArticleCell", bundle: nil), forCellWithReuseIdentifier: "HeadlineArticleCell")
        collectionView.register(UINib(nibName: "SegmentedControlCell", bundle: nil), forCellWithReuseIdentifier: "SegmentedControlCell")
        collectionView.setCollectionViewLayout(createCompositionalLayout(), animated: true)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = Colors.background.color
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = viewModel.title
    }
    
    func onRefresh() {
        
    }
    
    func onScrollEnd() {
        
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
                case 0:
                    return Layouts.headline.layout
                case 1:
                    return Layouts.segmentedControl.layout
                default:
                    return Layouts.category.layout
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
  
        layout.configuration = config
        return layout
    }
}

extension ViewController: ViewModelDelegate {
    func update() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func handle(error: Error) {
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.sections[indexPath.section].items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath) as! Cell
        
        cell.configureWith(viewModel: cellViewModel)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == viewModel.articles.count - 1 {
//            viewModel.currentPage += 1
//            viewModel.loadMore()
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            viewModel.onSelected(indexPath: indexPath)
            collectionView.reloadData()
            collectionView.reloadSections([2])
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
}
