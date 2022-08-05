//
//  MainTabBarViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
import SideMenu
import SafariServices
class MainTabBarViewController: UITabBarController {
    
    var menu:SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBarVC()
        configNavigation()
        
        
    }
    
   
   
    func configNavigation(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(tapMenu))
        // Create title button
           let titleViewButton = UIButton(type: .system)
           titleViewButton.setTitleColor(UIColor.black, for: .normal)
           titleViewButton.setTitle("Tap Me", for: .normal)

           // Create action listener
           titleViewButton.addTarget(self, action: #selector(MainTabBarViewController.titleViewButtonDidTap), for: .touchUpInside)

           // Set the title view with newly created button
           navigationItem.titleView = titleViewButton
    }
    @objc func titleViewButtonDidTap(_ sender: Any) {
        let vc = SearchLocationViewController()
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
   
    @objc func tapMenu(){
        let vc = MenuViewController()
        vc.delegate = self
        menu = SideMenuNavigationController(rootViewController: vc)
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
        present(menu!, animated: true, completion: nil)
    }
    
    func configTabBarVC(){
        //                let vc1 = UINavigationController(rootViewController: ToDayViewController())
        //                let vc2 = UINavigationController(rootViewController: HourlyViewController())
        //                let vc3 = UINavigationController(rootViewController: ByDayViewController())
        //                let vc4 = UINavigationController(rootViewController: RadaViewController())
        
        
        let vc1 = ToDayViewController()
        let vc2 = HourlyViewController()
        let vc3 = ByDayViewController()
        let vc4 = RadaViewController()
        vc1.title = "Today"
        vc2.title = "Hourly"
        vc3.title = "By day"
        vc4.title = "Rada"
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")
        
        setViewControllers([vc1,vc2, vc3, vc4], animated: true)
    }
    
}
extension MainTabBarViewController: MenuViewControllerDelegate{
    func didSelectedMenu(url: URL) {
        let vc = SFSafariViewController(url: url)
        menu?.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}