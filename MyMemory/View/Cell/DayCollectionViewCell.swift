//
//  HomeCollectionViewCell.swift
//  MyMemory
//
//  Created by NYEOK on 2023/01/07.
//

import UIKit
import FirebaseDatabase

class DayCollectionViewCell: UICollectionViewCell {
    // MARK: - PROPERTIES
    let db = Database.database().reference().child("Day")
    var imageLink: String?
    
    @IBOutlet var title: UILabel!
    @IBOutlet var body: UILabel!
    @IBOutlet weak var updateButton: UIButton!

    
    // MARK: - LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setButton(button: updateButton)
    }
    
    //MARK: - HELPERS
    
    private func setButton(button: UIButton) {
        button.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        button.layer.shadowOffset = CGSize(width: 2, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.masksToBounds = false
        button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.45)
        button.layer.borderWidth = 2
        button.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        button.layer.zPosition = -1
    }
}
