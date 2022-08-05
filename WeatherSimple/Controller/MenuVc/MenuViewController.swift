//
//  MenuViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
protocol MenuViewControllerDelegate: AnyObject {
    func didSelectedMenu(url: URL)
}
class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: MenuViewControllerDelegate?
    var menuHeader = MenuHeaderView()
    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
    }
    
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(MenuHeaderView.self, forHeaderFooterViewReuseIdentifier: MenuHeaderView.identifier)
        tableView.tableHeaderView = menuHeader
        menuHeader = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    }
}
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SideMenuItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        
        cell.textLabel?.text = SideMenuItem.allCases[indexPath.row].rawValue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = SideMenuItem.allCases[indexPath.row].link
        delegate?.didSelectedMenu(url: url)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuHeaderView.identifier)
//        return header
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
}
