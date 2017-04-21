//
//  ViewController.swift
//  Tab
//
//  Created by muukii on 4/22/17.
//  Copyright © 2017 eure. All rights reserved.
//

import UIKit

import EasyPeasy
import RxSwift
import RxCocoa

class FromViewController: UIViewController {
  
  private let button = UIButton(type: .system)
  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    view.addSubview(button)
    button <- Center()
    button.setTitle("Push", for: .normal)
    
    button.rx.tap.bind { [unowned self] in
      
      let controller = ToViewController()
      controller.hidesBottomBarWhenPushed = true
      self.navigationController?.pushViewController(controller, animated: true)
      }
      .disposed(by: disposeBag)
  }
}

class ToViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(white: 0.95, alpha: 1)
  }
  
  override var hidesBottomBarWhenPushed: Bool {
    get {
      return super.hidesBottomBarWhenPushed
    }
    set {
      super.hidesBottomBarWhenPushed = newValue
    }
  }
}

class NavigationController: UINavigationController, UINavigationControllerDelegate {
  
  let constantPushTransitionController = ConstantPushTransitionController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
  }
  
  public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    
    return nil
  }
  
  public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    switch operation {
    case .none:
      return nil
    case .push:
      
      constantPushTransitionController.forwardAnimation = true
      return constantPushTransitionController
      
    case .pop:

      constantPushTransitionController.forwardAnimation = false
      return constantPushTransitionController
    }
  }
}
