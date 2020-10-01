//
//  ViewController.swift
//  e-KYC
//
//  Created by Abdul R. Arraisi on 21/09/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControlView: UIPageControl!
    
    var imgArray = [
        ["austin-smart-70350",  "Title 1", "Desc"],
        ["clem-onojeghuo-196232", "Title 2", "Desc"],
        ["francesco-gallarotti-2497", "Title 3", "Desc"]]
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        pageControlView.numberOfPages = imgArray.count
        pageControlView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
         if counter < imgArray.count {
            let index = IndexPath.init(item: counter, section: 0)
             self.imageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControlView.currentPage = counter
             counter += 1
         } else {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             self.imageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControlView.currentPage = counter
             counter = 1
         }
     }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = UIImage(named: imgArray[indexPath.row][0])
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.cellImageView.image = UIImage(named: imgArray[indexPath.row][0])
//            return cell
//        }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = imageCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
