//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

class MyViewController: UIViewController {
    let Adj_Matr = [
        [-1, 4, 3, -1, -1, -1, -1],
        [-1, -1, -1, 2, -1, -1, -1],
        [-1, -1, -1, 2, 5, -1, -1],
        [-1, -1, 3, -1, -1, 1, -1],
        [-1, -1, -1, -1, -1, 1, 0],
        [-1, -1, -1, -1, 5, -1, 0],
        [-1, -1, -1, -1, -1, -1, -1]
    ]

    var cost = [0, -1, -1, -1, -1, -1, -1]
    var path = [0]
    var shortestPath = [Int]()

    func dfs(vert: Int) {
        if vert == 6 {
            print("Found")
            print(cost[6])
            print(path)
            shortestPath = path
            return
        }
        for i in 0 ..< Adj_Matr[vert].count {
            if Adj_Matr[vert][i] != -1, cost[i] == -1 || cost[vert] + Adj_Matr[vert][i] < cost[i] {
                cost[i] = cost[vert] + Adj_Matr[vert][i]
                path.append(i)
                dfs(vert: i)
                path.popLast()
            }
        }
    }

    func showPath(path: [Int]) {
        for nodeId in path {
            DispatchQueue.main.async {
                let my_circle: UIView = self.view.viewWithTag(nodeId + 1)! as UIView
                my_circle.backgroundColor = UIColor.red
            }

            print("Painted", Thread.isMainThread)
            sleep(2)
        }
    }

    let dx = [1, 5, 1, 5, 1, 5, 3]
    let dy = [0, 0, 1, 1, 2, 2, 3]

    @objc
    func startTapped() {
        dfs(vert: 0)
        DispatchQueue.global().async {
            self.showPath(path: self.shortestPath)
        }
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        var circles = [UIView]()

        for i in 0 ... 6 {
            let circle = UIView(frame: CGRect(x: 60 * dx[i], y: 80 + 150 * dy[i], width: 40, height: 40))
            circle.backgroundColor = UIColor.blue
            circle.layer.cornerRadius = 20
            circle.tag = i + 1

            circles.append(circle)
        }

        for circ in circles {
            view.addSubview(circ)
        }
        let btn = UIButton(frame: CGRect(x: 180, y: 40, width: 100, height: 40))
        btn.setTitle("Start DFS", for: .normal)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(startTapped), for: .touchUpInside)

        view.addSubview(btn)
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
