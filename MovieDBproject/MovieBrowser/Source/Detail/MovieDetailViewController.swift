//
//  MovieDetailViewController.swift
//  MovieBrowser
//
//  Created by Ranjith on 10/18/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var movieDescription: UITextView!
    @IBOutlet private weak var movieIconImageView: UIImageView!

    var  viewModel: MovieDetailViewModel

    // MARK: - Dependencies

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: MovieDetailViewController.self), bundle: Bundle.main)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    private func updateUI() {
        titleLabel.text = viewModel.result.title
        if let date = viewModel.result.releaseDate?.toDate() {
            dateLabel.text = "Release Date: \(date.toString())"

        }
        movieDescription.text = viewModel.result.overview
        if let posterPath = viewModel.result.posterPath {
            let url = String(format: AppConstants.imageURL,posterPath)
            movieIconImageView.imageFromURL(urlString: url)

        }
    }
}
