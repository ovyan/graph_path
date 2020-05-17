//: A UIKit based Playground for presenting user interface

import Foundation
import PlaygroundSupport
import UIKit

public extension UIFont {
    static func rounded(ofSize fontSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let fallback: UIFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        if #available(iOS 13.0, *), let descriptor = fallback.fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: fontSize)
        }
        return fallback
    }
}

public enum Colors {
    public enum Fonts {
        public static let blackDefault: UIColor = UIColor.black.withAlphaComponent(0.8)
        public static let blackTitle: UIColor = UIColor.black.withAlphaComponent(0.7)
        public static let blackAmount: UIColor = UIColor.black.withAlphaComponent(0.5)
    }

    public static let blackSeparator: UIColor = UIColor.black.withAlphaComponent(0.2)
}

class MyViewController3: UIViewController {
    func onMain(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }

    var previousBtn: UIButton!
    var nextBtn: UIButton!
    var pageLabel: UILabel!
    var pageNum = 0
    var pages = [UIView]()

    var secondView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 410, height: 600))

        let headerLabel = UILabel(frame: CGRect(x: 40, y: 20, width: 300, height: 100))
        headerLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        headerLabel.textColor = Colors.Fonts.blackDefault
        headerLabel.text = "Graph"
        headerLabel.numberOfLines = 2

        let descriptionLabel = UILabel(frame: CGRect(x: 40, y: 90, width: 350, height: 120))
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        descriptionLabel.textColor = Colors.Fonts.blackDefault
        descriptionLabel.text = "In mathematics, a graph is a structure amounting to a set of objects in which some pairs of the objects are in some sense 'related'."
        descriptionLabel.numberOfLines = 0

        let description2Label = UILabel(frame: CGRect(x: 40, y: 190, width: 350, height: 130))
        description2Label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        description2Label.textColor = Colors.Fonts.blackDefault
        description2Label.text = "The objects correspond to mathematical abstractions called vertices and each of the related pairs of vertices is called an edge."
        description2Label.numberOfLines = 0

        let img = UIImageView(frame: CGRect(x: 40, y: 320, width: 350, height: 250))
        img.image = #imageLiteral(resourceName: "graph1.png")

        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(description2Label)
        view.addSubview(img)

        let subviews = view.subviews
        for view in subviews {
            view.isHidden = true
        }

        return view
    }()

    var thirdView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 410, height: 600))

        let headerLabel = UILabel(frame: CGRect(x: 40, y: 20, width: 300, height: 100))
        headerLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        headerLabel.textColor = Colors.Fonts.blackDefault
        headerLabel.text = "Types of Graphs"
        headerLabel.numberOfLines = 1

        let directedGraph = UILabel(frame: CGRect(x: 40, y: 90, width: 350, height: 50))
        directedGraph.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        directedGraph.textColor = Colors.Fonts.blackDefault
        directedGraph.text = "Directed Graph"
        directedGraph.numberOfLines = 1

        let directedDescription = UILabel(frame: CGRect(x: 40, y: 130, width: 350, height: 50))
        directedDescription.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        directedDescription.textColor = Colors.Fonts.blackDefault
        directedDescription.text = "A graph in which edges have orientations."
        directedDescription.numberOfLines = 2

        let img = UIImageView(frame: CGRect(x: 10, y: 180, width: 250, height: 175))
        img.image = #imageLiteral(resourceName: "graph2_1.png")

        let weightedGraph = UILabel(frame: CGRect(x: 40, y: 350, width: 350, height: 50))
        weightedGraph.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        weightedGraph.textColor = Colors.Fonts.blackDefault
        weightedGraph.text = "Weighted Graph"
        weightedGraph.numberOfLines = 1

        let weightedDescription = UILabel(frame: CGRect(x: 40, y: 390, width: 350, height: 50))
        weightedDescription.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        weightedDescription.textColor = Colors.Fonts.blackDefault
        weightedDescription.text = "A graph in which a number is assigned to each edge."
        weightedDescription.numberOfLines = 2

        let img2 = UIImageView(frame: CGRect(x: 10, y: 440, width: 250, height: 175))
        img2.image = #imageLiteral(resourceName: "graph2_2.png")

        view.addSubview(headerLabel)
        view.addSubview(directedGraph)
        view.addSubview(directedDescription)
        view.addSubview(img)
        view.addSubview(weightedGraph)
        view.addSubview(weightedDescription)
        view.addSubview(img2)

        let subviews = view.subviews
        for view in subviews {
            view.isHidden = true
        }

        return view
    }()

    var fourthView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 410, height: 600))

        let headerLabel = UILabel(frame: CGRect(x: 40, y: 20, width: 300, height: 100))
        headerLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        headerLabel.textColor = Colors.Fonts.blackDefault
        headerLabel.text = "Shortest Path"
        headerLabel.numberOfLines = 1

        let descriptionLabel = UILabel(frame: CGRect(x: 40, y: 100, width: 300, height: 150))
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        descriptionLabel.textColor = Colors.Fonts.blackDefault
        descriptionLabel.text = "In graph theory, the shortest path problem is the problem of finding a path between two vertices in a graph such that the sum of the weights of its constituent edges is minimized."
        descriptionLabel.numberOfLines = 0

        let img = UIImageView(frame: CGRect(x: 40, y: 250, width: 350, height: 250))
        img.image = #imageLiteral(resourceName: "graph3.png")

        let explain = UILabel(frame: CGRect(x: 40, y: 460, width: 300, height: 100))
        explain.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        explain.textColor = Colors.Fonts.blackAmount
        explain.textAlignment = .center
        explain.text = "Length of the shortest path from A to D is 7 + 2 + 1 = 10"
        explain.numberOfLines = 0

        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(img)
        view.addSubview(explain)

        let subviews = view.subviews
        for view in subviews {
            view.isHidden = true
        }

        return view
    }()

    var fifthView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 410, height: 600))

        let headerLabel = UILabel(frame: CGRect(x: 40, y: 20, width: 300, height: 100))
        headerLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        headerLabel.textColor = Colors.Fonts.blackDefault
        headerLabel.text = "Shortest Path"
        headerLabel.numberOfLines = 1

        let explain = UILabel(frame: CGRect(x: 40, y: 100, width: 300, height: 100))
        explain.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        explain.textColor = Colors.Fonts.blackDefault
        explain.text = "Finding the shortest path in a graph remains an ubiquitous and important problem, which people are facing everyday."
        explain.numberOfLines = 0

        let home = UILabel(frame: CGRect(x: 40, y: 230, width: 300, height: 50))
        home.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        home.textColor = Colors.Fonts.blackDefault
        home.text = "Getting directions to home"
        home.numberOfLines = 1

        let access = UILabel(frame: CGRect(x: 40, y: 270, width: 300, height: 50))
        access.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        access.textColor = Colors.Fonts.blackDefault
        access.text = "Accessing Internet"
        access.numberOfLines = 1

        let friends = UILabel(frame: CGRect(x: 40, y: 310, width: 300, height: 50))
        friends.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        friends.textColor = Colors.Fonts.blackDefault
        friends.text = "Friends suggestions"
        friends.numberOfLines = 1

        let plant = UILabel(frame: CGRect(x: 40, y: 350, width: 300, height: 50))
        plant.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        plant.textColor = Colors.Fonts.blackDefault
        plant.text = "Plant and facility layout"
        plant.numberOfLines = 1

        let approaches = UILabel(frame: CGRect(x: 40, y: 430, width: 300, height: 100))
        approaches.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        approaches.textColor = Colors.Fonts.blackDefault
        approaches.text = "There are many approaches and algorithms to solve these problems. We will focus on the two main: DFS and BFS."
        approaches.numberOfLines = 0

        view.addSubview(headerLabel)
        view.addSubview(explain)
        view.addSubview(home)
        view.addSubview(access)
        view.addSubview(friends)
        view.addSubview(plant)
        view.addSubview(approaches)

        let subviews = view.subviews
        for view in subviews {
            view.isHidden = true
        }

        return view
    }()

    var sixthView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 410, height: 600))

        let headerLabel = UILabel(frame: CGRect(x: 40, y: 20, width: 320, height: 100))
        headerLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        headerLabel.textColor = Colors.Fonts.blackDefault
        headerLabel.text = "Depth-First Search"
        headerLabel.numberOfLines = 1

        let history = UILabel(frame: CGRect(x: 40, y: 100, width: 320, height: 100))
        history.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        history.textColor = Colors.Fonts.blackDefault
        history.text = "DFS was invented in the 19th century by French mathematician Charles Trémaux as a strategy for solving mazes."
        history.numberOfLines = 0

        let explain = UILabel(frame: CGRect(x: 40, y: 220, width: 320, height: 100))
        explain.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        explain.textColor = Colors.Fonts.blackDefault
        explain.text = "The algorithm starts at the root vertex and explores as far as possible along each branch before backtracking."
        explain.numberOfLines = 0

        // TODO: add slideshow
        let slide = UIImageView(frame: CGRect(x: 40, y: 350, width: 350, height: 250))
        slide.image = #imageLiteral(resourceName: "graph5_0.png")

        view.addSubview(headerLabel)
        view.addSubview(history)
        view.addSubview(explain)
        view.addSubview(slide)

        let subviews = view.subviews
        for view in subviews {
            view.isHidden = true
        }

        return view
    }()

    var seventhView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 410, height: 600))

        let headerLabel = UILabel(frame: CGRect(x: 40, y: 20, width: 350, height: 100))
        headerLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        headerLabel.textColor = Colors.Fonts.blackDefault
        headerLabel.text = "Breadth-First Search"
        headerLabel.numberOfLines = 1

        let history = UILabel(frame: CGRect(x: 40, y: 100, width: 310, height: 180))
        history.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        history.textColor = Colors.Fonts.blackDefault
        history.text = "It uses the opposite strategy as DFS, which instead explores the vertex branch as far as possible before being forced to backtrack and expand other vertices. Mostly used on undirected and not weighted graphs."
        history.numberOfLines = 0

        // TODO: add slideshow
        let slide = UIImageView(frame: CGRect(x: 40, y: 310, width: 350, height: 250))
        slide.image = #imageLiteral(resourceName: "graph6_0.png")

        view.addSubview(headerLabel)
        view.addSubview(history)
        view.addSubview(slide)

        let subviews = view.subviews
        for view in subviews {
            view.isHidden = true
        }

        return view
    }()
    
    var eigthView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 410, height: 600))

        let headerLabel = UILabel(frame: CGRect(x: 40, y: 20, width: 350, height: 100))
        headerLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        headerLabel.textColor = Colors.Fonts.blackDefault
        headerLabel.text = "Try it yourself"
        headerLabel.numberOfLines = 1

        let explore = UILabel(frame: CGRect(x: 40, y: 100, width: 300, height: 150))
        explore.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        explore.textColor = Colors.Fonts.blackDefault
        explore.text = "Explore how these algorithms work with real life examples!"
        explore.numberOfLines = 3
        
        let run = UILabel(frame: CGRect(x: 40, y: 220, width: 300, height: 180))
        run.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        run.textColor = Colors.Fonts.blackDefault
        run.text = "Run two other playgrounds get a better understading of DFS and BFS."
        run.numberOfLines = 4

        view.addSubview(headerLabel)
        view.addSubview(explore)
        view.addSubview(run)

        let subviews = view.subviews
        for view in subviews {
            view.isHidden = true
        }

        return view
    }()

    var firstView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 20, width: 410, height: 600))

        let headerLabel = UILabel(frame: CGRect(x: 40, y: 30, width: 300, height: 100))
        headerLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        headerLabel.textColor = Colors.Fonts.blackDefault
        headerLabel.text = "A small guide to Graph Theory"
        headerLabel.numberOfLines = 2

        let basicLabel = UILabel(frame: CGRect(x: 40, y: 160, width: 200, height: 40))
        basicLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        basicLabel.textColor = Colors.Fonts.blackDefault
        basicLabel.text = "Basic concepts"

        let historyLabel = UILabel(frame: CGRect(x: 40, y: 210, width: 200, height: 40))
        historyLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        historyLabel.textColor = Colors.Fonts.blackDefault
        historyLabel.text = "History"

        let applicationLabel = UILabel(frame: CGRect(x: 40, y: 260, width: 200, height: 40))
        applicationLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        applicationLabel.textColor = Colors.Fonts.blackDefault
        applicationLabel.text = "Applications"

        let algoLabel = UILabel(frame: CGRect(x: 40, y: 310, width: 200, height: 40))
        algoLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        algoLabel.textColor = Colors.Fonts.blackDefault
        algoLabel.text = "DFS and BFS"

        view.addSubview(headerLabel)
        view.addSubview(basicLabel)
        view.addSubview(historyLabel)
        view.addSubview(applicationLabel)
        view.addSubview(algoLabel)

        return view
    }()

    let myqueue = DispatchQueue(label: "myQQ", attributes: [])

    var isAnimating = false
    
    @objc func nextTapped() {
        pageNum += 1
        if isAnimating {
            isAnimating = false
        }
        if pageNum == 7 {
            onMain {
                self.nextBtn.isHidden = true
            }
        }
        if pageNum == 1 {
            onMain {
                self.previousBtn.isHidden = false
            }
        }
        onMain {
            self.pageLabel.text = "Page \(self.pageNum + 1)"
            self.pages[self.pageNum - 1].removeFromSuperview()
            self.view.addSubview(self.pages[self.pageNum])
        }
        let prevSubs = pages[pageNum - 1].subviews
        for view in prevSubs {
            view.isHidden = true
        }
        let subviews = pages[pageNum].subviews
        myqueue.async {
            self.isAnimating = true
            for view in subviews where self.isAnimating {
                self.onMain {
                    UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        view.isHidden = false
                    })
                }
                if !self.isAnimating {
                    break
                }
                usleep(200 * 1_000)
            }
            self.isAnimating = false
        }
    }

    @objc func previousTapped() {
        if isAnimating {
            isAnimating = false
        }
        pageNum -= 1
        if pageNum == 6 {
            onMain {
                self.nextBtn.isHidden = false
            }
        }
        if pageNum == 0 {
            onMain {
                self.previousBtn.isHidden = true
            }
        }
        onMain {
            self.pageLabel.text = "Page \(self.pageNum + 1)"
            self.pages[self.pageNum + 1].removeFromSuperview() // TODO: animate
            self.view.addSubview(self.pages[self.pageNum])
        }
        let prevSubs = pages[pageNum + 1].subviews
        for view in prevSubs {
            view.isHidden = true
        }
        let subviews = pages[pageNum].subviews
        myqueue.async {
            self.isAnimating = true
            for view in subviews where self.isAnimating {
                self.onMain {
                    UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        view.isHidden = false
                    })
                }
                if !self.isAnimating {
                    break
                }
                usleep(200 * 1_000)
            }
            self.isAnimating = false
        }
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        view.bounds.size.height = 770
        view.bounds.size.width = 450
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        previousBtn = UIButton(frame: CGRect(x: 20, y: 650, width: 100, height: 40))
        previousBtn.backgroundColor = .black
        previousBtn.addTarget(self, action: #selector(previousTapped), for: .touchUpInside)
        previousBtn.isHidden = true

        nextBtn = UIButton(frame: CGRect(x: 330, y: 650, width: 100, height: 40))
        nextBtn.backgroundColor = .black
        nextBtn.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)

        pageLabel = UILabel(frame: CGRect(x: 200, y: 700, width: 100, height: 30))
        pageLabel.text = "Page \(pageNum + 1)"
        pages = [firstView, secondView, thirdView, fourthView, fifthView, sixthView, seventhView, eigthView]

        view.addSubview(pages[0])
        view.addSubview(pageLabel)
        view.addSubview(previousBtn)
        view.addSubview(nextBtn)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

let a = MyViewController3()
a.preferredContentSize = a.view.frame.size
PlaygroundPage.current.liveView = a
