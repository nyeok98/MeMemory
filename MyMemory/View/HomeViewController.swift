//
//  ViewController.swift
//  MyMemory
//
//  Created by NYEOK on 2023/01/07.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - PROPERTIES

    @IBOutlet var homeCollectionView: UICollectionView!

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        let blogNib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        homeCollectionView.register(blogNib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }

    // MARK: - HELPER
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
