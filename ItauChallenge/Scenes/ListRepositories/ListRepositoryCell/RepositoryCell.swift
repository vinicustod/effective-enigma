//
//  RepositoryCell.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 23/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = 75/2
        }
    }

    @IBOutlet weak var usernameLabel: UILabel!

    var repository: Repository! {
        didSet {
            repositoryNameLabel.text = repository.fullName
            descriptionLabel.text = repository.description
            usernameLabel.text = repository.owner.login

            setUserImage(repository.owner.avatarUrl)
        }
    }

    private var dataTask: URLSessionDataTask?
    func setUserImage(_ url: URL) {
        dataTask?.cancel()
        userImageView.image = nil

        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let data = data, error == nil,
            let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.userImageView.image = image
            }
        })

        dataTask?.resume()
    }
}
