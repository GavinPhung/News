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
    @IBOutlet weak var button: UIButton!
    
    var viewModel: ArticleViewModel!
    
    func setViewModel(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateImage()
        titleLabel.text = viewModel.articleTitle
        dateLabel.text = viewModel.date
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        contentLabel.text = viewModel.content
        title = viewModel.title
        
        view.backgroundColor = Colors.background.color
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        authorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        contentLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .gray
        
        imageView.layer.cornerRadius = 5
        button.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        viewModel.onButtonPressed()
    }
}

extension ArticleViewController: ArticleImageViewModelDelegate {
    func urlFailure() {
        let alert = UIAlertController(title: viewModel.alertTitle, message: viewModel.alertMessage, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: viewModel.alertButtonTitle, style: UIAlertAction.Style.default, handler: nil))

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func update(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
