//
//  LoadingCell.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 24/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func setLoading(_ isLoading: Bool) {
        if isLoading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }

        self.activityIndicator.isHidden = !isLoading
    }
}
