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
    
    @IBOutlet var title: UILabel!
    @IBOutlet var body: UILabel!

    @IBAction func updateButton(_ sender: Any) {}

    
    // MARK: - LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - HELPERS
    func updateDay(_ day:Day) {
    }
}
