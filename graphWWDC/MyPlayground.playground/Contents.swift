//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let circle = UIView(frame: CGRect(x: 80, y: 80, width: 40, height: 40))
        circle.backgroundColor = UIColor.blue
        circle.layer.cornerRadius = 20
        
        let circle1 = UIView(frame: CGRect(x: 280, y: 280, width: 40, height: 40))
        circle1.backgroundColor = UIColor.red
        circle1.layer.cornerRadius = 20
        
        view.addSubview(circle)
        view.addSubview(circle1)
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
