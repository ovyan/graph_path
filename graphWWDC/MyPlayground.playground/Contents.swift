//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

func onMain(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}

class MyViewController: UIViewController {
    let contentLayer = CALayer()
    let contentLayer2 = CALayer()
    let contentLayerFinal = CALayer()

    var Adj_Matr = [
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1]
    ]

    var waitTime = [0, 1, 2, 3, 4, 5, 0]

    var cost = [0, -1, -1, -1, -1, -1, -1]
    var path = [0]
    var shortestPath = [Int]()
    
    func setupGraph() {
        cost = [0, -1, -1, -1, -1, -1, -1]
        path = [0]
        shortestPath = [Int]()
        Adj_Matr[0][1] = waitTime[1]
        Adj_Matr[0][2] = waitTime[2]
        Adj_Matr[1][3] = waitTime[3]
        Adj_Matr[2][3] = waitTime[3]
        Adj_Matr[2][4] = waitTime[4]
        Adj_Matr[3][2] = waitTime[2]
        Adj_Matr[3][5] = waitTime[5]
        Adj_Matr[4][5] = waitTime[5]
        Adj_Matr[4][6] = waitTime[6]
        Adj_Matr[5][4] = waitTime[4]
        Adj_Matr[5][6] = waitTime[6]
    }
    
    func randomizeTime() {
        for i in 1...5 {
            let timeLabel: UILabel = self.view.viewWithTag((i + 1) * 100) as! UILabel
            let randomInt = Int.random(in: 1..<7)
            waitTime[i] = randomInt
            timeLabel.text = "\(randomInt)"
        }
    }

    func dfs(vert: Int) {
        if vert == 6 {
            print("Found")
            print(cost[6])
            print(path)
            shortestPath = path
            showFinalPath(path: shortestPath)
            return
        }
        for i in 0 ..< Adj_Matr[vert].count {
            if Adj_Matr[vert][i] != -1, cost[i] == -1 || cost[vert] + Adj_Matr[vert][i] <= cost[i] {
                cost[i] = cost[vert] + Adj_Matr[vert][i]
                path.append(i)
                self.showPath(path: self.path)
                dfs(vert: i)
                path.popLast()
                self.showPath(path: self.path)
            }
        }
    }

    func showFinalPath(path: [Int]) {
        onMain {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.contentLayerFinal.sublayers?.forEach { $0.removeFromSuperlayer() }
            CATransaction.commit()
        }
        for i in 0 ..< path.count - 1 {
            onMain {
                let startId = path[i] + 1
                let endId = path[i + 1] + 1
                let startCircle: UIView = self.view.viewWithTag(startId)! as UIView
                let endCircle: UIView = self.view.viewWithTag(endId)! as UIView

                let line = UIBezierPath()
                line.move(to: CGPoint(x: startCircle.frame.midX, y: startCircle.frame.midY))
                line.addLine(to: CGPoint(x: endCircle.frame.midX, y: endCircle.frame.midY))

                let shapeLayer = CAShapeLayer()
                shapeLayer.path = line.cgPath
                shapeLayer.strokeColor = UIColor.green.cgColor
                shapeLayer.lineWidth = 16

                let circle = UIBezierPath(roundedRect: CGRect(x: endCircle.frame.midX - 8, y: endCircle.frame.midY - 8, width: 16, height: 16), cornerRadius: 8)

                let shapeLayerCircle = CAShapeLayer()
                shapeLayerCircle.path = circle.cgPath
                shapeLayerCircle.strokeColor = UIColor.green.cgColor
                shapeLayerCircle.lineWidth = 16

                CATransaction.begin()
                CATransaction.setDisableActions(true)
                self.contentLayerFinal.addSublayer(shapeLayer)
                self.contentLayerFinal.addSublayer(shapeLayerCircle)
                CATransaction.commit()
            }
        }
    }

    func showPath(path: [Int]) {
        for i in 0 ..< path.count - 1 {
            onMain {
                let startId = path[i] + 1
                let endId = path[i + 1] + 1
                let startCircle: UIView = self.view.viewWithTag(startId)! as UIView
                let endCircle: UIView = self.view.viewWithTag(endId)! as UIView

                let line = UIBezierPath()
                line.move(to: CGPoint(x: startCircle.frame.midX, y: startCircle.frame.midY))
                line.addLine(to: CGPoint(x: endCircle.frame.midX, y: endCircle.frame.midY))

                let shapeLayer = CAShapeLayer()
                shapeLayer.path = line.cgPath
                shapeLayer.strokeColor = UIColor.white.cgColor
                shapeLayer.lineWidth = 10

                let circle = UIBezierPath(roundedRect: CGRect(x: endCircle.frame.midX - 5, y: endCircle.frame.midY - 5, width: 10, height: 10), cornerRadius: 5)

                let shapeLayerCircle = CAShapeLayer()
                shapeLayerCircle.path = circle.cgPath
                shapeLayerCircle.strokeColor = UIColor.white.cgColor
                shapeLayerCircle.lineWidth = 10

                if path.count % 2 == 0 {
                    self.contentLayer.addSublayer(shapeLayer)
                    self.contentLayer.addSublayer(shapeLayerCircle)
                } else {
                    self.contentLayer2.addSublayer(shapeLayer)
                    self.contentLayer2.addSublayer(shapeLayerCircle)
                }
            }
        }
        usleep(200 * 1_000)
        onMain {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            if path.count % 2 == 1 {
                self.contentLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
            } else {
                self.contentLayer2.sublayers?.forEach { $0.removeFromSuperlayer() }
            }
            CATransaction.commit()
        }
    }

    func driveToPoint(car: UIView, endPoint: CGPoint) {
        onMain {
            UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut], animations: {
                car.center = endPoint
            }, completion: nil)
        }
    }

    func turnCar(car: UIView, endPoint: CGPoint) {
        let direction = CGPoint(x: endPoint.x - car.center.x, y: endPoint.y - car.center.y)
        let angle = atan2(direction.y, direction.x)
        onMain {
            UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
                car.transform = CGAffineTransform(rotationAngle: angle + .pi)
            }, completion: nil)
        }
    }
    
    

    func driveCar(path: [Int]) {
        let car: UIView = self.view.viewWithTag(1_337)! as UIView
        for i in 1 ..< path.count {
            let endCircle: UIView = self.view.viewWithTag(path[i] + 1)! as UIView
            let endPoint = CGPoint(x: endCircle.frame.midX, y: endCircle.frame.midY)
            turnCar(car: car, endPoint: endPoint)
            sleep(1)
            driveToPoint(car: car, endPoint: endPoint)
            sleep(2) // wait for completion
            sleep(UInt32(waitTime[path[i]]))
        }
    }

    @objc
    func startTapped() {
        DispatchQueue.global().async {
            self.setupGraph()
            self.dfs(vert: 0)
            self.driveCar(path: self.shortestPath)
        }
    }
    
    @objc
    func randomBtnTapped() {
        randomizeTime()
    }
    
    @objc
    func circleTapped(sender : UITapGestureRecognizer) {
        print(sender.view?.tag)
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        var circles = [UIView]()
        let dx = [1, 9, 1, 9, 1, 9, 5]
        let dy = [0, 0, 2, 2, 4, 4, 5]

        for i in 0 ... 6 {
            let circle = UIView(frame: CGRect(x: 38 * dx[i], y: 42 + 105 * dy[i], width: 72, height: 72))
            circle.backgroundColor = UIColor.systemBlue
            circle.layer.cornerRadius = 35
            circle.alpha = 0.2
            circle.tag = i + 1
            let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.circleTapped))
            circle.addGestureRecognizer(gesture)

            circles.append(circle)
        }

        for i in 1 ... 5 {
            let label = UILabel(frame: CGRect(x: 38 * dx[i] + 15, y: 42 + 45 + 105 * dy[i], width: 40, height: 20))
            label.text = "\(i)"
            label.textAlignment = .center
            label.backgroundColor = .red
            label.tag = (i + 1) * 100

            view.addSubview(label)
        }

        for circ in circles {
            view.addSubview(circ)
        }

        let startButton = UIButton(frame: CGRect(x: 130, y: 40, width: 100, height: 40))
        startButton.setTitle("Start DFS", for: .normal)
        startButton.backgroundColor = .red
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        
        let randomButton = UIButton(frame: CGRect(x: 250, y: 40, width: 100, height: 40))
        randomButton.setTitle("Randomize", for: .normal)
        randomButton.backgroundColor = .red
        randomButton.addTarget(self, action: #selector(randomBtnTapped), for: .touchUpInside)

        let car = UIView(frame: CGRect(x: 54, y: 68, width: 40, height: 22))
        car.transform = CGAffineTransform(rotationAngle: .pi)
        car.layer.contents = #imageLiteral(resourceName: "car.png").cgImage
        car.tag = 1_337

        view.addSubview(randomButton)
        view.addSubview(startButton)

        view.layer.addSublayer(contentLayerFinal)
        view.layer.addSublayer(contentLayer)
        view.layer.addSublayer(contentLayer2)
        
        view.addSubview(car)

        view.bounds.size.height = 750
        view.bounds.size.width = 450
        view.layer.contents = #imageLiteral(resourceName: "field1.png").cgImage

        self.view = view
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentLayerFinal.bounds = view.layer.bounds
        contentLayerFinal.position = view.center
        contentLayer.bounds = view.layer.bounds
        contentLayer.position = view.center
        contentLayer2.bounds = view.layer.bounds
        contentLayer2.position = view.center
    }
}

// Present the view controller in the Live View window
let a = MyViewController()
a.preferredContentSize = a.view.frame.size
PlaygroundPage.current.liveView = a
