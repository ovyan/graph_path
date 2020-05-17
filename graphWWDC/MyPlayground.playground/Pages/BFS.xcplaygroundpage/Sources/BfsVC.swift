import Foundation
import PlaygroundSupport
import UIKit

public class BfsViewController: UIViewController {
    func onMain(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }

    let dx = [38, 190, 342, 38, 190, 342, 38, 190, 342, 38, 190, 342, 342]
    let dy = [16, 16, 16, 166, 166, 166, 316, 316, 316, 466, 466, 466, 616]

    let circleLightsLayer = CALayer()
    let contentLayer = CALayer()
    let contentLayer2 = CALayer()
    let contentLayerFinal = CALayer()

    var car = UIView()

    var lengthLabel = UILabel()

    var tagToChange = 0

    var isRunning = false

    var Adj_Matr = Array(repeating: Array(repeating: -1, count: 13), count: 13)
    var waitTime = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 1]
    var cost = [0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    var path = [0]
    var shortestPath = [Int]()
    var allPaths = [[Int]]()
    var q = [Int]()
    var maxCost = 0
    var marker = 0

    func setupGraph() {
        cost = [0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
        path = [0]
        shortestPath = [0, 1, 2, 5, 8, 11, 12]
        allPaths = [[Int]]()
        q = [Int]()
        maxCost = 0
        marker = 0
        Adj_Matr[0][1] = waitTime[1]
        Adj_Matr[0][3] = waitTime[3]
        Adj_Matr[1][2] = waitTime[2]
        Adj_Matr[1][4] = waitTime[4]
        Adj_Matr[2][5] = waitTime[5]
        Adj_Matr[3][4] = waitTime[4]
        Adj_Matr[3][6] = waitTime[6]
        Adj_Matr[4][3] = waitTime[3]
        Adj_Matr[4][5] = waitTime[5]
        Adj_Matr[4][7] = waitTime[7]
        Adj_Matr[5][4] = waitTime[4]
        Adj_Matr[5][8] = waitTime[8]
        Adj_Matr[6][7] = waitTime[7]
        Adj_Matr[6][9] = waitTime[9]
        Adj_Matr[7][6] = waitTime[6]
        Adj_Matr[7][8] = waitTime[8]
        Adj_Matr[7][10] = waitTime[10]
        Adj_Matr[8][7] = waitTime[7]
        Adj_Matr[8][11] = waitTime[11]
        Adj_Matr[9][10] = waitTime[10]
        Adj_Matr[10][11] = waitTime[11]
        Adj_Matr[11][12] = waitTime[12]
    }

    func randomizeTime() {
        for i in 1 ... 11 {
            let timeLabel: UILabel = self.view.viewWithTag((i + 1) * 100) as! UILabel
            waitTime[i] = 1
            onMain {
                timeLabel.text = "\(1)"
            }
        }
    }

    func bfs() {
        q.append(0)
        while !q.isEmpty {
            let vert = q.removeFirst()
            if cost[vert] > maxCost {
                maxCost = cost[vert]
                marker += 1
                usleep(2_000 * 1_000)
            }
            for i in 0 ..< Adj_Matr[vert].count where isRunning {
                if Adj_Matr[vert][i] != -1, cost[i] == -1 {
                    cost[i] = cost[vert] + 1
                    q.append(i)
                    showPath(currentPath: [vert, i])
                }
            }
        }
    }

    func showPath(currentPath: [Int]) {
        var pathColor = UIColor.black.cgColor
        switch marker { // TODO: fix colors
        case 0:
            pathColor = UIColor.systemYellow.cgColor
        case 1:
            pathColor = UIColor.systemRed.cgColor
        case 2:
            pathColor = UIColor.systemBlue.cgColor
        default:
            pathColor = UIColor.black.cgColor
        }
        for i in stride(from: 0, to: currentPath.count - 1, by: 1) where isRunning {
            onMain {
                let startId = currentPath[i] + 1
                let endId = currentPath[i + 1] + 1
                let startCircle: UIView = self.view.viewWithTag(startId)! as UIView
                let endCircle: UIView = self.view.viewWithTag(endId)! as UIView

                let line = UIBezierPath()
                line.move(to: CGPoint(x: startCircle.frame.midX, y: startCircle.frame.midY))
                line.addLine(to: CGPoint(x: endCircle.frame.midX, y: endCircle.frame.midY))

                let shapeLayer = CAShapeLayer()
                shapeLayer.path = line.cgPath
                shapeLayer.strokeColor = pathColor
                shapeLayer.lineWidth = 10

                let circle = UIBezierPath(roundedRect: CGRect(x: startCircle.frame.midX - 5, y: startCircle.frame.midY - 5, width: 10, height: 10), cornerRadius: 5)

                let shapeLayerCircle = CAShapeLayer()
                shapeLayerCircle.path = circle.cgPath
                shapeLayerCircle.strokeColor = pathColor
                shapeLayerCircle.lineWidth = 10

                CATransaction.begin()
                CATransaction.setDisableActions(true)
                if currentPath.count % 2 == 0 {
                    self.contentLayer.addSublayer(shapeLayer)
                    self.contentLayer.addSublayer(shapeLayerCircle)
                } else {
                    self.contentLayer2.addSublayer(shapeLayer)
                    self.contentLayer2.addSublayer(shapeLayerCircle)
                }
                CATransaction.commit()
            }
        }
        if !isRunning { return }
        onMain {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            if currentPath.count % 2 == 1 {
                self.contentLayer.sublayers?.removeAll()
            } else {
                self.contentLayer2.sublayers?.removeAll()
            }
            CATransaction.commit()
        }
    }

    func driveToPoint(car: UIView, endPoint: CGPoint) {
        if isRunning {
            onMain {
                UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
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
                circleLayer.strokeColor = UIColor.systemRed.cgColor
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
        onMain {
            self.contentLayerFinal.opacity = 0.2
        }
        for i in 1 ..< path.count where isRunning {
            let endCircle = DispatchQueue.main.sync {
                self.view.viewWithTag(path[i] + 1)! as UIView
            }
            let endPoint = DispatchQueue.main.sync {
                CGPoint(x: endCircle.frame.midX, y: endCircle.frame.midY)
            }
            turnCar(car: car, endPoint: endPoint)
            var slept = 0.0
            while slept < 2, isRunning {
                slept += 0.1
                usleep(100 * 1_000)
            }
            animateCircle(duration: TimeInterval(waitTime[path[i]]), circle: endCircle)
            slept = 0.0
            while slept < Double(waitTime[path[i]]), isRunning {
                slept += 0.1
                usleep(100 * 1_000)
            }
            if isRunning, path[i] < 12 {
                onMain {
                    let redLight = self.view.viewWithTag((path[i] + 1) * 1_000)! as UIView
                    redLight.alpha = 0
                    let greenLight = self.view.viewWithTag((path[i] + 1) * 10_000)! as UIView
                    greenLight.alpha = 1
                }
            }
        }
    }

    func cleanScreen() {
        onMain {
            self.circleLightsLayer.sublayers?.removeAll()
            self.contentLayerFinal.sublayers?.removeAll()
            self.contentLayerFinal.opacity = 1
            self.contentLayer.sublayers?.removeAll()
            self.contentLayer2.sublayers?.removeAll()
            self.car.removeFromSuperview()
            self.car = UIView(frame: CGRect(x: 53, y: 40, width: 40, height: 22))
            self.car.layer.shadowColor = UIColor.black.cgColor
            self.car.layer.shadowOpacity = 0.5
            self.car.layer.shadowOffset = CGSize.zero
            self.car.layer.shadowRadius = 5
            self.car.transform = CGAffineTransform(rotationAngle: .pi)
            self.car.layer.contents = #imageLiteral(resourceName: "car2.png").cgImage
            self.car.tag = 1_337
            for i in 1 ... 11 {
                let redLight = self.view.viewWithTag((i + 1) * 1_000)! as UIView
                redLight.alpha = 1
                let greenLight = self.view.viewWithTag((i + 1) * 10_000)! as UIView
                greenLight.alpha = 0
            }
            self.lengthLabel.text = "Shortest Length: -"
            self.view.addSubview(self.car)
        }
    }

    func showAlert() {
        onMain {
            let alert = UIAlertController(title: "Congratulations!", message: "You have found the shortest path using BFS", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                self.cleanScreen()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    let myqueue = DispatchQueue(label: "myQQ", attributes: [])

    @objc
    func startTapped(sender: UIButton) {
        if !isRunning {
            sender.setImage(#imageLiteral(resourceName: "stop.png"), for: .normal)
            myqueue.async {
                self.isRunning = true
                self.cleanScreen()
                if self.isRunning { self.setupGraph() } else { return }
                if self.isRunning { self.bfs() } else { return }
                self.onMain {
                    self.contentLayer.sublayers?.removeAll()
                    self.contentLayer2.sublayers?.removeAll()
                    self.lengthLabel.text = "Shortest Length: 5"
                }
                if self.isRunning { self.driveCar(path: self.shortestPath) } else { return }
                if self.isRunning { self.showAlert() } else { return }
                if self.isRunning {
                    self.onMain {
                        sender.setImage(#imageLiteral(resourceName: "triangle.png"), for: .normal)
                    }
                } else { return }
                self.isRunning = false
            }
        } else {
            isRunning = false
            sender.setImage(#imageLiteral(resourceName: "triangle.png"), for: .normal)
            cleanScreen()
        }
    }

    func setupCircles() {
        for i in 0 ... 12 {
            let circle = UIView(frame: CGRect(x: dx[i], y: dy[i], width: 70, height: 70))
            circle.backgroundColor = UIColor.blue
            circle.layer.cornerRadius = 35
            circle.alpha = 0.05
            circle.tag = i + 1

            self.view.addSubview(circle)
        }
    }

    func setupRedLights() {
        for i in 1 ... 11 {
            let redLight = UIView(frame: CGRect(x: dx[i] + 16, y: dy[i] + 20, width: 16, height: 16))
            redLight.backgroundColor = UIColor.red
            redLight.layer.cornerRadius = 8
            redLight.clipsToBounds = true
            redLight.layer.shadowPath = UIBezierPath(roundedRect: redLight.bounds, cornerRadius: redLight.layer.cornerRadius).cgPath
            redLight.layer.shadowColor = UIColor.red.cgColor
            redLight.layer.shadowOpacity = 1
            redLight.layer.shadowOffset = CGSize(width: 0, height: 0)
            redLight.layer.shadowRadius = 5
            redLight.layer.masksToBounds = false
            redLight.alpha = 1
            redLight.tag = (i + 1) * 1_000

            self.view.addSubview(redLight)
        }
    }

    func setupGreenLights() {
        for i in 1 ... 11 {
            let greenLight = UIView(frame: CGRect(x: dx[i] + 38, y: dy[i] + 20, width: 16, height: 16))
            greenLight.backgroundColor = UIColor.green
            greenLight.layer.cornerRadius = 8
            greenLight.clipsToBounds = true
            greenLight.layer.shadowPath = UIBezierPath(roundedRect: greenLight.bounds, cornerRadius: greenLight.layer.cornerRadius).cgPath
            greenLight.layer.shadowColor = UIColor.green.cgColor
            greenLight.layer.shadowOpacity = 1
            greenLight.layer.shadowOffset = CGSize(width: 0, height: 0)
            greenLight.layer.shadowRadius = 5
            greenLight.layer.masksToBounds = false
            greenLight.alpha = 0
            greenLight.tag = (i + 1) * 10_000

            self.view.addSubview(greenLight)
        }
    }

    func setupLabels() {
        for i in 1 ... 11 {
            let label = UILabel(frame: CGRect(x: 15 + dx[i], y: 45 + dy[i], width: 40, height: 20))
            label.text = "\(i)"
            label.textAlignment = .center
            label.tag = (i + 1) * 100
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)

            self.view.addSubview(label)
        }
    }

    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let startButton = UIButton(frame: CGRect(x: 50, y: 626, width: 50, height: 50))
        startButton.setImage(#imageLiteral(resourceName: "triangle.png"), for: .normal)
        startButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)

        car = UIView(frame: CGRect(x: 53, y: 40, width: 40, height: 22))
        car.layer.shadowColor = UIColor.black.cgColor
        car.layer.shadowOpacity = 0.5
        car.layer.shadowOffset = CGSize.zero
        car.layer.shadowRadius = 5
        car.transform = CGAffineTransform(rotationAngle: .pi)
        car.layer.contents = #imageLiteral(resourceName: "car2.png").cgImage
        car.tag = 1_337

        view.addSubview(lengthLabel)
        view.addSubview(car)
        view.addSubview(startButton)

        view.bounds.size.height = 770
        view.bounds.size.width = 450
        view.layer.contents = #imageLiteral(resourceName: "fieldBFS.png").cgImage

        self.view = view
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupRedLights()
        setupCircles()
        setupGreenLights()
        setupLabels()
        randomizeTime()

        lengthLabel.frame = CGRect(x: 150, y: 550, width: 200, height: 50)
        lengthLabel.text = "Shortest Length: -"
        lengthLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)

        view?.layer.addSublayer(circleLightsLayer)
        view?.layer.addSublayer(contentLayerFinal)
        view?.layer.addSublayer(contentLayer)
        view?.layer.addSublayer(contentLayer2)
    }

    public override func viewWillLayoutSubviews() {
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
