//
//  MainTabBarController.swift
//  ios
//
//  Created by 태로고침 on 2020/08/31.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        
        self.delegate = self
        
        setUpTabBar()
    }
    
    func setUpTabBar(){
        let homeViewController  = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem.image = UIImage(named: "tab_icon_home")
        homeViewController.tabBarItem.title = "홈"
        
        let nearViewController =  NearViewController()
        nearViewController.tabBarItem.image = UIImage(named: "tab_icon_near")
        nearViewController.tabBarItem.title = "내 근처"
        
        let sellViewPopUp = UINavigationController()
        sellViewPopUp.tabBarItem.image = UIImage(named: "tab_icon_write")
        sellViewPopUp.tabBarItem.title = "글쓰기"
        
        let chattingViewControroller = UINavigationController(rootViewController: ChattingViewController())
        chattingViewControroller.tabBarItem.image = UIImage(named: "tab_icon_chat")
        chattingViewControroller.tabBarItem.title = "채팅"
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem.image = UIImage(named: "tab_icon_profile")
        profileViewController.tabBarItem.title = "나의 당근"
        
        viewControllers = [homeViewController, nearViewController,sellViewPopUp, chattingViewControroller, profileViewController]
    }
    
    // 3번째 탭브 버튼(글쓰기 버튼) 누르면 뷰컨트롤러로 이동하지 않고 팝업창만 띄움
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[2]{
            let presentCommingSoonPopUp = UIStoryboard(name: "SellViewPopUp", bundle: Bundle.main)
             let popUP = presentCommingSoonPopUp.instantiateViewController(withIdentifier: "SellViewPopUp") as? SellViewPopUp
            popUP!.modalPresentationStyle = .custom
            self.present(popUP!,animated: true, completion: nil)
            
            return false
        }else{
            return true
        }
    }
}


