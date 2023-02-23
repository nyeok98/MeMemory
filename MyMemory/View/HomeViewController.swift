//
//  ViewController.swift
//  MyMemory
//
//  Created by NYEOK on 2023/01/07.
//

import Alamofire
import FirebaseDatabase
import SwiftyJSON
import UIKit

class HomeViewController: UIViewController {
    // MARK: - PROPERTIES

    let db = Database.database().reference().child("Day")
    var dayList: [Day] = []
    var currentIndex: Int = 0
    let fireBaseService = FireBaseService.shared
    
    @IBOutlet var dayCollectionView: UICollectionView!
    @IBAction func addButtonTapped(_ sender: Any) {
        currentIndex = -1
        performSegue(withIdentifier: "goToAddDayVC", sender: self)
    }
   

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        registerNib()
        fetchDays()
    }

    // MARK: - HELPER
    
    func fetchDays() {
        fireBaseService.fetchData { [weak self] result in
            switch result {
            case .success(let days):
                self?.dayList.append(contentsOf: days)
                self?.dayList.sort(by: { day1, day2 in
                    return day1.date >= day2.date
                })
                self?.dayCollectionView.reloadData()
            case .failure(let err):
                print(err)
            }
        }
    }

    private func registerNib() {
        let dayNib = UINib(nibName: "DayCollectionViewCell", bundle: nil)
        dayCollectionView.register(dayNib, forCellWithReuseIdentifier: "DayCollectionViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddDayVC" && currentIndex >= 0 {
            if let destinationVC = segue.destination as? AddDayViewController {
                    destinationVC.day = dayList[currentIndex]
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayList.count
    } 

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dayCollectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as? DayCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.title.text = dayList[indexPath.row].title
        cell.body.text = dayList[indexPath.row].body
        cell.updateButton.addTarget(self, action: #selector(performUpdate), for: .touchUpInside)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    @objc func performUpdate(sender: UIButton) {
        performSegue(withIdentifier: "goToAddDayVC", sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // Calculate the center of the collection view
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: scrollView.contentOffset.y + (scrollView.frame.height / 2))
        
        // Find the index path of the cell closest to the center
        if let indexPath = dayCollectionView.indexPathForItem(at: center) {
            // If the current index is different from the index of the closest cell, scroll to that cell
            if indexPath.item != currentIndex {
                currentIndex = indexPath.item
                dayCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            }
        }
    }
}
