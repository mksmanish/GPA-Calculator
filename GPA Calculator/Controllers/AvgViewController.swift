//
//  AvgViewController.swift
//  GPA Calculator
//
//  Created by manish on 20/08/21.
//

import UIKit
import iCarousel
/// this class is used for avergae calculatiion
class AvgViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var viwCoursel: iCarousel!
    var screenType:Int = 0
    @IBOutlet weak var pageControl: UIPageControl!
    var arrImages = [String]()
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.setupNavigation()
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        arrImages.append("ad2")
        arrImages.append("ad1")
        arrImages.append("ad3")
        arrImages.append("ad4")
        arrImages.append("ad5")
        viwCoursel.delegate = self
        viwCoursel.dataSource = self
        viwCoursel.isPagingEnabled = true
        pageControl.hidesForSinglePage = true
        self.pageControl.numberOfPages = self.arrImages.count
        if screenType == 4 {
            self.navigationItem.title = "Average of 4"
        }else if screenType == 5 {
            self.navigationItem.title = "Average of 5"
        }else if screenType == 100 {
            self.navigationItem.title = "Average of 100"
        }else{
            self.navigationItem.title = ""
        }
    }
    
    func setupNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill")?.withTintColor(UIColor.white), style: .plain, target: self, action: #selector(handleSettings))
    }
    
    @objc func handleSettings() {
        let storyborad = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyborad.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnNewValue(_ sender: Any) {
        let storyborad = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyborad.instantiateViewController(identifier: "CalculationViewController") as! CalculationViewController
        vc.screenType = screenType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
extension AvgViewController: iCarouselDelegate,iCarouselDataSource {
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
        
    }
    
    
}
