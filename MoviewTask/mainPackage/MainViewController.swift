//
//  MainViewController.swift
//  MoviewTask
//
//  Created by Mohamed Emad on 1/12/19.
//  Copyright © 2019 Baianat. All rights reserved.
//

import UIKit
import NewBaseFrameWork

class MainViewController: UITabBarController {
    
    let popularActorsViewController: PoplarPersonsViewController = PoplarPersonsViewController.getObject()
    let searchViewController: SearchViewController = SearchViewController.getObject()
    let subViewForTabBar = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    /**
     setup the views for this view controller
     */
    func setupView(){
        self.subViewForTabBar.frame = CGRect(x: 0, y: UIApplication.shared.keyWindow?.frame.height ?? self.view.frame.height - 120, width: 1000, height: 120)
        self.subViewForTabBar.backgroundColor = .black
        tabBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        popularActorsViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "poplar icon") , tag: 0)
        searchViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Icon-Small") , tag: 0)
        
        viewControllers =  [popularActorsViewController, searchViewController]
        for viewController in viewControllers ?? [UIViewController()]{
            viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
        // update navigation controller bar (hide back button and update tint color to be black)
        self.navigationController?.setNavigationControllerTintToBlack()
        self.hideBackTitle()
        
    }
    

}
