//
//  NewsArticleCell.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import UIKit

protocol CellProtocol: UICollectionViewCell  {
    func configureWith(viewModel: CellViewModel)
}

typealias Cell = CellProtocol & UICollectionViewCell

protocol CellViewModel {
    var cellIdentifier: String { get }
}

class NewsArticleCell: Cell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureWith(viewModel: CellViewModel) {
        guard let viewModel = viewModel as? NewsArticleCellViewModel else { return }
        titleLabel.text = viewModel.title
        self.imageView.image = viewModel.image
        imageView.layer.cornerRadius = 5
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.backgroundColor = UIColor(red: 248/255.0, green: 249/255.0, blue: 253/255.0, alpha: 1)
    }

}
