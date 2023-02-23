//
//  AddDayViewController.swift
//  MyMemory
//
//  Created by 신동녘 on 2023/01/30.
//

import UIKit
import FirebaseDatabase

class AddDayViewController: UIViewController {
    // MARK: - PROPERTIES
    
    let db = Database.database().reference().child("Day")
    let DidDismissAddDayViewController: Notification.Name = Notification.Name("DidDismissAddDayViewController")
    
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
        let encoder = JSONEncoder()
        
        if let viewController = presentingViewController as? HomeViewController {
            self.dismiss(animated: true) {
                do {
                    let data = try encoder.encode(newDay)
                    let json = try JSONSerialization.jsonObject(with: data)
                    self.db.child(newDay.date).setValue(json)
                } catch {
                    print(error)
                }
                viewController.dayList.append(newDay)
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
