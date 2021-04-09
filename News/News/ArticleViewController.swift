//
//  ArticleViewController.swift
//  News
//
//  Created by Gavin Phung on 09/04/2021.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var viewModel: ArticleViewModel!
    
    func setViewModel(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        contentLabel.text = viewModel.content
    }
}
