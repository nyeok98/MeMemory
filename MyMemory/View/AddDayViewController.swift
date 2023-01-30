//
//  AddDayViewController.swift
//  MyMemory
//
//  Created by 신동녘 on 2023/01/30.
//

import UIKit

class AddDayViewController: UIViewController {
    // MARK: - PROPERTIES
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - HELPERS
    @IBAction func finishButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
