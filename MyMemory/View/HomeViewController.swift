//
//  ViewController.swift
//  MyMemory
//
//  Created by NYEOK on 2023/01/07.
//

import Alamofire
import SwiftyJSON
import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController {
    // MARK: - PROPERTIES
    var ref: DatabaseReference!

    @IBOutlet var homeCollectionView: UICollectionView!
    var dayArray: [Day] = []

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        let dayNib = UINib(nibName: "DayCollectionViewCell", bundle: nil)
        homeCollectionView.register(dayNib, forCellWithReuseIdentifier: "DayCollectionViewCell")
        
        self.ref = Database.database().reference()
        let itemRef = self.ref.child("list")
        itemRef.setValue(1)
    }

    // MARK: - HELPER
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as? DayCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
