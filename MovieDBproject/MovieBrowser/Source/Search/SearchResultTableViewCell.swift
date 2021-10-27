//
//  SearchResultTableViewCell.swift
//  MovieBrowser
//
//  Created by Ranjith on 10/18/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

    var result: Result?  {
        didSet {
            titleLabel.text = result?.title
            ratingLabel.text = "\(result?.voteAverage ?? 0)"
            dateLabel.text = result?.releaseDate
        }
    }
    
}
