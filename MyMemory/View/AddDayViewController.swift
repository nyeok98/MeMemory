//
//  AddDayViewController.swift
//  MyMemory
//
//  Created by 신동녘 on 2023/01/30.
//

import UIKit

class AddDayViewController: UIViewController {
    // MARK: - PROPERTIES
    
    let DidDismissAddDayViewController: Notification.Name = Notification.Name("DidDismissAddDayViewController")
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - HELPERS
    @IBAction func finishButtonTapped(_ sender: Any) {
        let newDay = Day(title: titleTextField.text ?? "", body: bodyTextField.text ?? "", imageURL: "")
        
        if let viewController = presentingViewController as? HomeViewController {
            self.dismiss(animated: true) {
                viewController.dayList.append(newDay)
                viewController.dayCollectionView.reloadData()
            }
        }
    }
}
