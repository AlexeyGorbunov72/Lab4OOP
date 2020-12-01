//
//  ViewController.swift
//  VKClient
//
//  Created by Alexey on 17.11.2020.
//

import UIKit
class FeedViewController: UIViewController, UITableViewDelegate{

    @objc func didPress(notification: NSNotification) {
        if let attachment = notification.userInfo?["attachment"] as? Attachment {
            let showContentVC:
            ShowCntentController = UIStoryboard(
                name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "showContentVC") as! ShowCntentController
            showContentVC.attachment = attachment
            self.navigationController?.pushViewController(showContentVC, animated: true)
        }
    }
    
    @IBOutlet weak var feed: UITableView!
    var posts: [Post] = []
    let concentrate =  FeedViewControllerConcentrate()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Типа короче лента"
        feed.delegate = self
        feed.rowHeight = UITableView.automaticDimension
        feed.estimatedRowHeight = 1400
        concentrate.feed = feed
        NotificationCenter.default.addObserver(self, selector: #selector(didPress), name: NSNotification.Name(rawValue: "mediaViewDidPress"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
