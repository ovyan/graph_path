//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

class MyViewController: UIViewController {
    func onMain(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }

    let circleLightsLayer = CALayer()
    let contentLayer = CALayer()
    let contentLayer2 = CALayer()
    let contentLayerFinal = CALayer()

    var car = UIView()
    var controlView = UIView()
    var plusBtn = UIButton(type: .system)
    var minusBtn = UIButton(type: .system)
    var doneBtn = UIButton(type: .system)
    var tagToChange = 0
    var isRunning = false

    var Adj_Matr = [
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1]
    ]

    var waitTime = [0, 1, 2, 3, 4, 5, 1]

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
        for i in 1 ... 5 {
            let timeLabel: UILabel = self.view.viewWithTag((i + 1) * 100) as! UILabel
            var randomInt = Int.random(in: 1 ..< 9)
            if i == 3 {
                randomInt = Int.random(in: 1 ..< 4)
            }
            if i == 4 {
                randomInt = Int.random(in: 4 ..< 9)
            }
            waitTime[i] = randomInt
            timeLabel.text = "\(randomInt)"
        }
    }

    func dfs(vert: Int) {
        if !isRunning {
            return
        }
        if vert == 6 {
            print(cost[6])
            print(path)
            shortestPath = path
            showFinalPath(path: shortestPath)
            return
        }
        for i in 0 ..< Adj_Matr[vert].count where isRunning {
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
        for i in 0 ..< path.count - 1 where isRunning {
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
//        for i in 0 ..< path.count - 1 where isRunning {
//            onMain {
//                let startId = path[i] + 1
//                let endId = path[i + 1] + 1
//                let startCircle: UIView = self.view.viewWithTag(startId)! as UIView
//                let endCircle: UIView = self.view.viewWithTag(endId)! as UIView
//
//                let line = UIBezierPath()
//                line.move(to: CGPoint(x: startCircle.frame.midX, y: startCircle.frame.midY))
//                line.addLine(to: CGPoint(x: endCircle.frame.midX, y: endCircle.frame.midY))
//
//                let shapeLayer = CAShapeLayer()
//                shapeLayer.path = line.cgPath
//                shapeLayer.strokeColor = UIColor.white.cgColor
//                shapeLayer.lineWidth = 10
//
//                let circle = UIBezierPath(roundedRect: CGRect(x: endCircle.frame.midX - 5, y: endCircle.frame.midY - 5, width: 10, height: 10), cornerRadius: 5)
//
//                let shapeLayerCircle = CAShapeLayer()
//                shapeLayerCircle.path = circle.cgPath
//                shapeLayerCircle.strokeColor = UIColor.white.cgColor
//                shapeLayerCircle.lineWidth = 10
//
//                if path.count % 2 == 0 {
//                    self.contentLayer.addSublayer(shapeLayer)
//                    self.contentLayer.addSublayer(shapeLayerCircle)
//                } else {
//                    self.contentLayer2.addSublayer(shapeLayer)
//                    self.contentLayer2.addSublayer(shapeLayerCircle)
//                }
//            }
//        }
//        usleep(100 * 1_000)
//        onMain {
//            CATransaction.begin()
//            CATransaction.setDisableActions(true)
//            if path.count % 2 == 1 {
//                self.contentLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
//            } else {
//                self.contentLayer2.sublayers?.forEach { $0.removeFromSuperlayer() }
//            }
//            CATransaction.commit()
//        }
    }

    func driveToPoint(car: UIView, endPoint: CGPoint) {
        if isRunning {
            onMain {
                UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut], animations: {
                    car.center = endPoint
                }, completion: nil)
            }
        }
    }

    func turnCar(car: UIView, endPoint: CGPoint) {
        if isRunning {
            onMain {
                let direction = CGPoint(x: endPoint.x - car.center.x, y: endPoint.y - car.center.y)
                let angle = atan2(direction.y, direction.x)
                UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
                    car.transform = CGAffineTransform(rotationAngle: angle + .pi)
                }, completion: { _ in
                    self.driveToPoint(car: car, endPoint: endPoint)
                })
            }
        }
    }

    func animateCircle(duration: TimeInterval, circle: UIView) {
        if isRunning {
            onMain {
                let circlePath = UIBezierPath(arcCenter: CGPoint(x: circle.frame.midX, y: circle.frame.midY), radius: 70 / 2, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)

                let circleLayer = CAShapeLayer()
                circleLayer.path = circlePath.cgPath
                circleLayer.fillColor = UIColor.clear.cgColor
                circleLayer.strokeColor = UIColor.red.cgColor
                circleLayer.lineWidth = 3.0
                circleLayer.strokeEnd = 0.0

                self.circleLightsLayer.addSublayer(circleLayer)

                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.duration = duration
                animation.fromValue = 0
                animation.toValue = 1
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

                circleLayer.strokeEnd = 1.0

                circleLayer.add(animation, forKey: "animateCircle")
            }
        }
    }

    func driveCar(path: [Int]) {
        for i in 1 ..< path.count where isRunning {
            let endCircle = DispatchQueue.main.sync {
                self.view.viewWithTag(path[i] + 1)! as UIView
            }
            let endPoint = DispatchQueue.main.sync {
                CGPoint(x: endCircle.frame.midX, y: endCircle.frame.midY)
            }
            // add here
            turnCar(car: car, endPoint: endPoint)
            var slept = 0.0
            while slept < 3, isRunning {
                slept += 0.1
                usleep(100 * 1000)
            }
            animateCircle(duration: TimeInterval(waitTime[path[i]]), circle: endCircle)
            slept = 0.0
            while slept < Double(waitTime[path[i]]), isRunning {
                slept += 0.1
                usleep(100 * 1000)
            }
        }
    }

    func setupControlView() {
        controlView = UIView()
        controlView.backgroundColor = .white
        controlView.layer.cornerRadius = 5
        plusBtn.setTitle("+", for: .normal)
        plusBtn.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        plusBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        plusBtn.tintColor = .white
        plusBtn.backgroundColor = .darkGray

        minusBtn.setTitle("-", for: .normal)
        minusBtn.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        minusBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        minusBtn.tintColor = .white
        minusBtn.backgroundColor = .darkGray

        doneBtn.setTitle("Done", for: .normal)
        doneBtn.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    func showControlView(circle: UIView) {
        tagToChange = circle.tag
        controlView.frame = CGRect(x: circle.frame.midX - 40, y: circle.frame.maxY + 5, width: 80, height: 80)
        plusBtn.frame = CGRect(x: controlView.frame.midX - 30, y: controlView.frame.minY + 10, width: 25, height: 25)
        minusBtn.frame = CGRect(x: controlView.frame.midX + 5, y: controlView.frame.minY + 10, width: 25, height: 25)
        doneBtn.frame = CGRect(x: controlView.frame.midX - 30, y: controlView.frame.minY + 45, width: 60, height: 25)

        self.view.addSubview(controlView)
        self.view.addSubview(plusBtn)
        self.view.addSubview(minusBtn)
        self.view.addSubview(doneBtn)
    }

    @objc
    func plusTapped(sender: UIButton) {
        let label: UILabel = self.view.viewWithTag(tagToChange * 100) as! UILabel
        if waitTime[tagToChange - 1] < 9 {
            waitTime[tagToChange - 1] += 1
        }
        label.text = "\(waitTime[tagToChange - 1])"
    }

    @objc
    func minusTapped(sender: UIButton) {
        let label: UILabel = self.view.viewWithTag(tagToChange * 100) as! UILabel
        if waitTime[tagToChange - 1] > 1 {
            waitTime[tagToChange - 1] -= 1
        }
        label.text = "\(waitTime[tagToChange - 1])"
    }

    func hideControlView() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        plusBtn.removeFromSuperview()
        minusBtn.removeFromSuperview()
        doneBtn.removeFromSuperview()
        controlView.removeFromSuperview()
        CATransaction.commit()
    }

    @objc
    func doneTapped(sender: UIButton) {
        hideControlView()
    }

    func cleanScreen() {
        onMain {
            self.hideControlView()
            self.circleLightsLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.contentLayerFinal.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.car.removeFromSuperview()
            self.car = UIView(frame: CGRect(x: 54, y: 68, width: 40, height: 22))
            self.car.transform = CGAffineTransform(rotationAngle: .pi)
            self.car.layer.contents = #imageLiteral(resourceName: "car.png").cgImage
            self.car.tag = 1_337
            self.view.addSubview(self.car)
        }
    }

    func showAlert() {
        onMain {
            let alert = UIAlertController(title: "Congratulations!", message: "You have found the shortest path using DFS", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                self.cleanScreen()
        }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc
    func startTapped(sender: UIButton) {
        if !isRunning {
            sender.setImage(#imageLiteral(resourceName: "stop.png"), for: .normal)
            DispatchQueue.global().async {
                self.isRunning = true
                self.cleanScreen()
                if self.isRunning { self.setupGraph() } else {
                    return
                }
                if self.isRunning { self.dfs(vert: 0) } else {
                    return
                }
                if self.isRunning { self.driveCar(path: self.shortestPath) } else {
                    return
                }
                if self.isRunning { self.showAlert() } else {
                    return
                }
                if self.isRunning { self.onMain { sender.setImage(#imageLiteral(resourceName: "Triangle.png"), for: .normal) } } else {
                    return
                }
                self.isRunning = false
            }
        } else {
            isRunning = false
            sender.setImage(#imageLiteral(resourceName: "Triangle.png"), for: .normal)
            cleanScreen()
        }
    }

    @objc
    func randomBtnTapped() {
        if !isRunning {
            randomizeTime()
        }
    }

    @objc
    func circleTapped(sender: UITapGestureRecognizer) {
        if !isRunning {
            let tag = sender.view?.tag
            if tag != 1, tag != 7 {
                showControlView(circle: sender.view!)
            }
        }
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let dx = [1, 9, 1, 9, 1, 9, 5]
        let dy = [0, 0, 2, 2, 4, 4, 5]

        for i in 0 ... 6 {
            let circle = UIView(frame: CGRect(x: 38 * dx[i], y: 42 + 105 * dy[i], width: 70, height: 70))
            circle.backgroundColor = UIColor.systemBlue
            circle.layer.cornerRadius = 35
            circle.alpha = 0.5
            circle.tag = i + 1
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.circleTapped))
            circle.addGestureRecognizer(gesture)

            view.addSubview(circle)
        }

        for i in 1 ... 5 {
            let label = UILabel(frame: CGRect(x: 38 * dx[i] + 15, y: 42 + 45 + 105 * dy[i], width: 40, height: 20))
            label.text = "\(i)"
            label.textAlignment = .center
            label.backgroundColor = .red
            label.tag = (i + 1) * 100

            view.addSubview(label)
        }

        let startButton = UIButton(frame: CGRect(x: 130, y: 40, width: 50, height: 50))
        startButton.setImage(#imageLiteral(resourceName: "Triangle.png"), for: .normal)
        startButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)

        let randomButton = UIButton(type: .system)
        randomButton.frame = CGRect(x: 250, y: 40, width: 100, height: 50)
        randomButton.setTitle("Random", for: .normal)
        randomButton.backgroundColor = .white
        randomButton.layer.cornerRadius = 10
        randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        randomButton.tintColor = .systemBlue
        randomButton.addTarget(self, action: #selector(randomBtnTapped), for: .touchUpInside)

        car = UIView(frame: CGRect(x: 54, y: 68, width: 40, height: 22))
        car.transform = CGAffineTransform(rotationAngle: .pi)
        car.layer.contents = #imageLiteral(resourceName: "car.png").cgImage
        car.tag = 1_337

        view.addSubview(randomButton)
        view.addSubview(startButton)

        view.layer.addSublayer(circleLightsLayer)
        view.layer.addSublayer(contentLayerFinal)
        view.layer.addSublayer(contentLayer)
        view.layer.addSublayer(contentLayer2)

        view.addSubview(car)
        setupControlView()

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
        circleLightsLayer.bounds = view.layer.bounds
        circleLightsLayer.position = view.center
    }
}

// Present the view controller in the Live View window
let a = MyViewController()
a.preferredContentSize = a.view.frame.size
PlaygroundPage.current.liveView = a
