//
//  OptionsViewController.swift
//  GPA Calculator
//
//  Created by manish on 20/08/21.
//

import UIKit
import iCarousel
/// This class is tha main class for Home controller.

class HomeViewController: UIViewController {
    //MARK:- @IBOUTLETS
    
    @IBOutlet weak var viwAdvertise: UIView!
    @IBOutlet weak var viwCoursel: iCarousel!
    @IBOutlet weak var btnAverage4: UIButton!
    @IBOutlet weak var btnAverage5: UIButton!
    @IBOutlet weak var btnAverage100: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    var arrImages = [String]()
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        arrImages.append("ad5")
        arrImages.append("ad2")
        arrImages.append("ad3")
        arrImages.append("ad4")
        arrImages.append("ad1")
        self.setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        btnAverage4.addTarget(self, action: #selector(btnAverage4Tapped), for: .touchUpInside)
        btnAverage5.addTarget(self, action: #selector(btnAverage5Tapped), for: .touchUpInside)
        btnAverage100.addTarget(self, action: #selector(btnAverage100Tapped), for: .touchUpInside)
        viwCoursel.delegate = self
        viwCoursel.dataSource = self
        viwCoursel.isPagingEnabled = true
        pageControl.hidesForSinglePage = true
        self.pageControl.numberOfPages = self.arrImages.count
      //  self.viwCoursel.reloadData()
    }
    @objc func btnAverage4Tapped() {
        
        let storyborad = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyborad.instantiateViewController(identifier: "AvgViewController") as! AvgViewController
        vc.screenType = 4
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func btnAverage5Tapped() {
        let storyborad = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyborad.instantiateViewController(identifier: "AvgViewController") as! AvgViewController
        vc.screenType = 5
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @objc func btnAverage100Tapped() {
        
        let storyborad = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyborad.instantiateViewController(identifier: "AvgViewController") as! AvgViewController
        vc.screenType = 100
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    //MARK:- @IBAction
    @IBAction func btnSettings(_ sender: UIButton) {
        let storyborad = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyborad.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: iCarouselDelegate,iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return arrImages.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView
    {
        let viw = Bundle.main.loadNibNamed("AdvertiseView", owner: self, options: nil)![0] as! Advertisefile
        viw.frame.size = CGSize(width: viwCoursel.frame.size.width  , height: viwCoursel.frame.size.height)
        viw.layer.cornerRadius = 10.0
        viw.imgView.layer.cornerRadius = 10.0
        viw.imgView.clipsToBounds = true
        viw.imgView.image = UIImage(named: arrImages[index])
        viw.imgView.contentMode = .scaleAspectFill
        return viw
    }
    /// valueFor(Set value)
    ///
    /// - Parameters:
    ///   - carousel: carousel
    ///   - option: option
    ///   - value: value
    /// - Returns: value
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.5
        }
        return value
    }
    /// Scrolling End
    ///
    /// - Parameter carousel: carousel
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel)
    {
        self.pageControl.currentPage = carousel.currentItemIndex
        self.pageControl.currentPageIndicatorTintColor = .red
        self.pageControl.pageIndicatorTintColor = .blue
        Utility.shared.updatePageControl(pager: self.pageControl)
     //   Utility.shared.updatePageControl(pager: self.pageControl)
        
    }
    
    
}
