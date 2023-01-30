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

    @IBOutlet var dayCollectionView: UICollectionView!
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToAddDayVC", sender: self)
    }
    var dayList: [Day] = []

    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        registerNib()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
                self.dayList = dayList
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
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 400)
    }
}
