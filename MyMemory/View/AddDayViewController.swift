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
    
    let fireBaseService = FireBaseService.shared
    
    var day: Day?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields(day)
    }
    
    
    // MARK: - HELPERS
    @IBAction func finishButtonTapped(_ sender: Any) {
        let newDay = Day(title: titleTextField.text ?? "", body: bodyTextField.text ?? "", imageURL: "")
        
        if let viewController = presentingViewController as? HomeViewController {
            self.dismiss(animated: true) {
                self.fireBaseService.putData(day: newDay)
                viewController.dayList.insert(newDay, at: 0)
                viewController.dayCollectionView.reloadData()
            }
        }
    }
    
    private func setFields(_ day: Day?) -> Void {
        if let day = day {
            titleTextField.text = day.title
            bodyTextField.text = day.body
        }
    }
}
