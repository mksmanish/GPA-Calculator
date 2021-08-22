//
//  SpashViewController.swift
//  GPA Calculator
//
//  Created by manish on 20/08/21.
//

import UIKit

class SplashViewController: UIViewController {
    
    

   override func viewDidLoad() {
        super.viewDidLoad()
      //   self.setup()

    
    //    Run timer to show splash screen for 3 secs
    //     Move to a background thread to do some long running work
        DispatchQueue.global(qos: .background).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.perform(#selector(self.endSplashScreen), with: nil, afterDelay: 2.0)
            }
        }
    }

    
    func setup() {
        let layer1 = CAGradientLayer()

        layer1.colors = [

          UIColor(red: 0.993, green: 0.684, blue: 0.983, alpha: 0).cgColor,

          UIColor(red: 0, green: 0.388, blue: 0.714, alpha: 1).cgColor

        ]

        layer1.locations = [0, 1]

        layer1.startPoint = CGPoint(x: 0.25, y: 0.5)

        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)

        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))

        layer1.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)

        layer1.position = view.center

        view.layer.addSublayer(layer1)
    }
    
    //Handle end of splash screen here
    @objc func endSplashScreen()
    {
 
        let loginViewController = UIStoryboard(name: "Start", bundle: nil).instantiateInitialViewController()
        loginViewController?.modalPresentationStyle = .overFullScreen
        self.present(loginViewController!, animated: true, completion: nil)

    }
}
