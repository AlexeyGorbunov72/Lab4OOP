//
//  ViewController.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var feed: UITableView!
    var posts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Типа короче лента"
        feed.delegate = self
        feed.dataSource = self
        feed.rowHeight = UITableView.automaticDimension
        feed.estimatedRowHeight = 300
        feed.register(FeedTableViewCell.self, forCellReuseIdentifier: "feedCell")
        Api.getFeed(){[weak self] response in
            guard let self = self else {
                return
            }
            self.posts = response.items
            DispatchQueue.main.async {
                self.feed.reloadData()
            }
            
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let feedCell = feed
            .dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        feedCell.addPostView(post: post)
        return feedCell
    }
}
