//
//  RepositoryPullRequestsCell.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 23/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

class RepositoryPullRequestsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!

    var pullRequest: PullRequest! {
        didSet {
            titleLabel.text = pullRequest.title
            bodyLabel.text = pullRequest.body
            usernameLabel.text = pullRequest.user.login

            setUserImage(pullRequest.user.avatarUrl)
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
