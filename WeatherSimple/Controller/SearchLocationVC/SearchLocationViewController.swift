//
//  SearchLocationViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
import EzPopup
import CoreData

class SearchLocationViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchTextfield: UITextField!
    //đối tương dung để truy vấn vào bộ nhớ
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextfield()
        do {
            let data = try context.fetch(Location.fetchRequest())
            print(data)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func configTextfield(){
        searchTextfield.delegate = self
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchResult(){
        let vc = ResultLoctionSearchViewController()
//        let popVc = PopupViewController(contentController: vc, position: .offsetFromView(CGPoint(x: 0, y: searchTextfield.frame.height), searchTextfield), popupWidth: view.frame.width - 40, popupHeight: view.bounds.height/2)
//        let popVc = PopupViewController(contentController: vc, position: ., popupWidth: <#T##CGFloat?#>, popupHeight: <#T##CGFloat?#>)
//        present(popVc, animated: true, completion: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension SearchLocationViewController:UITextFieldDelegate{
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//
//        if let text = textField.text, !text.isEmpty {
//            print(textField.text)
//            searchResult()
//        } else {
//
//        }
//
//    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchTextfield {
            searchResult()
        }
    }
    
}

extension SearchLocationViewController:ResultLoctionSearchViewControllerDelegate{
    func tapLocation(searchLocation: SearchLocation) {
        print("")
    }
    
    
    
    
}
