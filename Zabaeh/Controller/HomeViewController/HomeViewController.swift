//
//  HomeViewController.swift
//  Zabaeh
//
//  Created by Awady on 11/18/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageSliderCollectionView: UICollectionView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var sliderData = [SliderModel]()
    var homeData = [HomeModel]()
    
    var curruntIndex = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
        
        imageSliderCollectionView.delegate = self
        imageSliderCollectionView.dataSource = self
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        let silderCellNib = UINib(nibName: "imageSliderCell", bundle: nil)
        self.imageSliderCollectionView.register(silderCellNib, forCellWithReuseIdentifier: "imageSliderCell")
        
        let homeCellNib = UINib(nibName: "HomeCollectionCell", bundle: nil)
        self.homeCollectionView.register(homeCellNib, forCellWithReuseIdentifier: "HomeCollectionCell")
        
        pageControl?.numberOfPages = sliderData.count
        startTimer()    
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction() {
        let scrolPosition = (curruntIndex < sliderData.count - 1) ? curruntIndex + 1 : 0
        self.imageSliderCollectionView.scrollToItem(at: IndexPath(item: scrolPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func configData() {
        HomeAPI.instance.FetchHomeData { (Success) in
            if  Success == true {
                print("You are in home page")
                self.sliderData = HomeAPI.instance.sliderData
                self.homeData = HomeAPI.instance.homeData
                
                self.imageSliderCollectionView.reloadData()
                self.homeCollectionView.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.imageSliderCollectionView {
        return sliderData.count
        }
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.imageSliderCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageSliderCell", for: indexPath) as! imageSliderCell
            cell.configCell(sliderData: sliderData[indexPath.row])
        return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
            cell.configCell(homeData: homeData[indexPath.row])
            cell.layer.cornerRadius = 5
            cell.layer.shadowRadius = 5
            cell.layer.shadowColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
            cell.layer.shadowOpacity = 0.7
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.imageSliderCollectionView {
            return CGSize(width: self.imageSliderCollectionView.frame.width, height: 200)
        } else {
            return CGSize(width: (collectionView.frame.size.width / 3) - 5, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.homeCollectionView {
            let view = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
            view.categoryID = self.homeData[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        curruntIndex = Int(scrollView.contentOffset.x / self.imageSliderCollectionView.frame.size.width)
        pageControl?.currentPage = curruntIndex
    }
}

