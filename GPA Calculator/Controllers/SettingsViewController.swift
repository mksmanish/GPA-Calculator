//
//  SettingsViewController.swift
//  GPA Calculator
//
//  Created by manish on 20/08/21.
//

import UIKit
import iCarousel
/// This class provides the setting configuration in the app.
class SettingsViewController: UIViewController {
    //MARK:- @IBOUTLETS
    
    @IBOutlet weak var Advertise: UIView!
    @IBOutlet weak var btnGooglePay: UIButton!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet weak var btnGeneralSettings: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var viwCoursel: iCarousel!
    var arrImages = [String]()
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        arrImages.append("ad4")
        arrImages.append("ad2")
        arrImages.append("ad3")
        arrImages.append("ad1")
        arrImages.append("ad5")
        viwCoursel.delegate = self
        viwCoursel.dataSource = self
        viwCoursel.isPagingEnabled = true
        pageControl.hidesForSinglePage = true
        self.pageControl.numberOfPages = self.arrImages.count
//        btnPrivacyPolicy.addTarget(self, action: #selector(btnPrivacyTapped), for: UIControl.Event.touchUpInside)
    }
   @objc func btnPrivacyTapped() {
        
        let storyborad = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyborad.instantiateViewController(identifier: "PrivacyViewController") as! PrivacyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
extension SettingsViewController: iCarouselDelegate,iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return arrImages.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView
    {
        let viw = Bundle.main.loadNibNamed("AdvertiseView", owner: self, options: nil)![0] as! Advertisefile
        viw.frame.size = CGSize(width: viwCoursel.frame.size.width  , height: viwCoursel.frame.size.height)
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
        
    }
    
    
}

