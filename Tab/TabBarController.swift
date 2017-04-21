//
//  TabBarController.swift
//  Tab
//
//  Created by muukii on 4/22/17.
//  Copyright © 2017 eure. All rights reserved.
//

import UIKit

import EasyPeasy

import RxSwift
import RxCocoa

final class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let c = FromViewController()
    let vc = NavigationController(rootViewController: c)
    
    setViewControllers([
      vc
      ], animated: false)
    
    let v = UIView()
    
    tabBar.addSubview(v)
    v <- Center()
    
    print(view)
    print(view.subviews)
    
    view.subviews.first?.rx.observe(CGRect.self, "frame").bind { frame in
      
      print(frame)
      
      if frame != self.view.frame {
        self.view.subviews.first?.frame = self.view.frame
      }
    }
  }
  
  override var tabBar: UITabBar {
    get {
      return super.tabBar
    }
  }
}
