//
//  SearchLocationViewController.swift
//  WeatherSimple
//
//  Created by MAC on 8/5/22.
//

import UIKit
import EzPopup

class SearchLocationViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var searchTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextfield()
    }
    
    func configTextfield(){
        searchTextfield.delegate = self
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchResult(){
        let vc = ResultLoctionSearchViewController()
        let popVc = PopupViewController(contentController: vc, position: .offsetFromView(CGPoint(x: 0, y: searchTextfield.frame.height), searchTextfield), popupWidth: view.frame.width - 40, popupHeight: view.bounds.height/2)
        
        present(popVc, animated: true, completion: nil)
    }
}

extension SearchLocationViewController:UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if let text = textField.text, !text.isEmpty {
            print(textField.text)
            searchResult()
        } else {
            
        }
        
    }
}
