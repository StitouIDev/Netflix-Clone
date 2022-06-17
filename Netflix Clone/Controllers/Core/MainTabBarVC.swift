//
//  ViewController.swift
//  Netflix Clone
//
//  Created by HAMZA on 8/6/2022.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let home = UINavigationController(rootViewController: HomeVC())
        let upComing = UINavigationController(rootViewController: UpcomingVC())
        let search = UINavigationController(rootViewController: SearchVC())
        let download = UINavigationController(rootViewController: DownloadsVC())
        
        home.tabBarItem.image = UIImage(systemName: "house")
        upComing.tabBarItem.image = UIImage(systemName: "play.circle")
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        download.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        home.title = "Home"
        upComing.title = "Coming Soon"
        search.title = "Top Search"
        download.title = "Downloads"
        
        tabBar.tintColor = .label
        
        
        
        
        setViewControllers([home, upComing, search, download], animated: true)
    }


}

