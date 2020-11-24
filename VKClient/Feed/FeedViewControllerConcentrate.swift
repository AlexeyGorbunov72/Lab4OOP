//
//  FeedViewControllerConcentrate.swift
//  VKClient
//
//  Created by Alexey on 20.11.2020.
//

import Foundation
import UIKit

class FeedViewControllerConcentrate: NSObject,  UITableViewDataSource{
    var posts: [Post] = []
    var feed: UITableView?{
        didSet{
            feed!.dataSource = self
            feed!.register(FeedTableViewCell.self, forCellReuseIdentifier: "feedCell")
            loadSomeFeed(count: 20)
        }
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let feed = feed else {
            fatalError()
        }
        let post = posts[indexPath.row]
        let feedCell = feed
            .dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        print(indexPath.row)
        feedCell.isUserInteractionEnabled = true
        feedCell.addPostView(post: post)
        feedCell.selectionStyle = .none
        feedCell.clipsToBounds = true
        if abs(posts.count - indexPath.row) < 10{
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.loadSomeFeed()
            }
            
        }
        return feedCell
    }
    func loadSomeFeed(count: Int = 50){
        VK.api.getFeed(count: count){[weak self] response in
            guard let self = self else {
                return
            }
            self.posts += response.items
            DispatchQueue.main.async {
                self.feed!.reloadData()
            }
            
        }
    }
}
