//
//  Utility.swift
//  GPA Calculator
//
//  Created by manish on 20/08/21.
//

import Foundation
import UIKit
class Utility {
    static let shared = Utility()
    /// This method is used to update the page control with new UI
    /// - Parameter pager: as UIPageControl
   public func updatePageControl(pager: UIPageControl) {
        let sub = pager.subviews
        if sub.count > 0 {
            let sub1 = sub[0].subviews
            if sub1.count > 0 {
                let sub2 = sub1[0].subviews
                for (index, dot) in sub2.enumerated() {
                    if index == pager.currentPage {
                        dot.tintColor = UIColor.red
                        dot.backgroundColor = UIColor.black
                        dot.layer.cornerRadius = dot.frame.size.height / 2;
                        dot.layer.borderColor = UIColor.black.cgColor
                    } else {
                        dot.tintColor = .clear
                        dot.backgroundColor = .clear
                        dot.layer.cornerRadius = dot.frame.size.height / 2
                        dot.layer.borderColor = UIColor.black.cgColor
                        dot.layer.borderWidth = 1
                    }
                }
            }
        }
    }
}
