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
    // Create title button
    let titleViewButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBarVC()
        configNavigation()
        
        
    }
    
    
    
    func configNavigation(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(tapMenu))
        
        titleViewButton.setTitleColor(UIColor.black, for: .normal)
        titleViewButton.setTitle("Current Location", for: .normal)
//        titleViewButton.frame.width = 200
        // Create action listener
        titleViewButton.addTarget(self, action: #selector(MainTabBarViewController.titleViewButtonDidTap), for: .touchUpInside)
        
        // Set the title view with newly created button
        navigationItem.titleView = titleViewButton
    }
    @objc func titleViewButtonDidTap(_ sender: Any) {
        let vc = SearchLocationViewController()
        vc.delegate = self
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        view.window!.layer.add(transition, forKey: kCATransition)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
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
    func didTapSetting() {
        menu?.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    func didSelectedMenu(url: URL) {
        let vc = SFSafariViewController(url: url)
        menu?.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainTabBarViewController: SearchLocationViewControllerDelegate{
    func sendata(id: String) {
        
    }
    
    func changeLocation(location: Location) {
        let title = location.localizedName
        titleViewButton.setTitle(title, for: .normal)
    }
    
    func choseLocation(searchLocation: SearchLocation) {
        let title = searchLocation.LocalizedName!
        titleViewButton.setTitle(title, for: .normal)
    }
    
}
