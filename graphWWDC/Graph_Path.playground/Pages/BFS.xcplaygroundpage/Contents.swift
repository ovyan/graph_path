import Foundation
import PlaygroundSupport
import UIKit

let bfsVC = BfsViewController()
bfsVC.preferredContentSize = bfsVC.view.frame.size
/*:
# Not my favorite letters, but I still like them.
# The B F S
_ _ _
 Hope you enjoyed helping other people (drivers) using DFS! And now it is time to switch to BFS.
_ _ _
BFS is less popular algorithm rather than DFS, because to work correctly it requires that all weights of a graph should be either 0 or 1. And it is harder to implement it in the __oriented__ graph.
___
So, our town has changed a bit. Now all of the traffic lights are set to 1 second.
 
Click the play button at the bottom to let the algorithm solve this problem! It visualizes each step it takes, and on each step shows the moves it made with one color. Once the algorithm finds the best one, the ambulance will start driving this route to the hospital.
_ _ _
 Hey, run the BFS Playground here!
 */
PlaygroundPage.current.liveView = bfsVC
