//
//  ViewController.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setupNavigationBar()
        setUpCollectionView()
        setUpRefreshControl()
        viewModel.onViewDidLoad()
    }
    
    func setUpRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refreshControl
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
    
    @objc func refresh() {
        refreshControl.beginRefreshing()
        viewModel.onRefresh()
        refreshControl.endRefreshing()
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
        let error = error as? CustomError
        let alert = UIAlertController(title: viewModel.alertTitle, message: error?.message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: viewModel.buttonTitle, style: UIAlertAction.Style.default, handler: { [weak self] (action) in
            self?.viewModel.onViewDidLoad()
        }))

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func categoryClicked() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.reloadSections([2])
        }
    }
    
    func goTo(article: Article) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController else { return }
        vc.setViewModel(viewModel: ArticleViewModel(article: article))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.sections[indexPath.section].items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.configureWith(viewModel: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.onSelected(indexPath: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
}
