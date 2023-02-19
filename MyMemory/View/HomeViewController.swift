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
    
    @IBOutlet var dayCollectionView: UICollectionView!
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToAddDayVC", sender: self)
    }
   

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        registerNib()
        fetchDayData()
    }

    // MARK: - HELPER

    func fetchDayData() {
        db.observeSingleEvent(of: .value) { snapshot in
            guard let snapData = snapshot.value as? [String: Any] else { return }
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            do {
                let decoder = JSONDecoder()
                let dayList = try decoder.decode([Day].self, from: data)
                self.dayList.append(contentsOf: dayList)
                self.dayCollectionView.reloadData()
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }

    private func registerNib() {
        let dayNib = UINib(nibName: "DayCollectionViewCell", bundle: nil)
        dayCollectionView.register(dayNib, forCellWithReuseIdentifier: "DayCollectionViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddDayVC" {
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
