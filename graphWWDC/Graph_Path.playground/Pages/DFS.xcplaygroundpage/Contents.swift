import Foundation
import PlaygroundSupport
import UIKit

let dfsVC = DfsViewController()
dfsVC.preferredContentSize = dfsVC.view.frame.size
/*:
# Oh, my 3 favorite letters! D F S
_ _ _
## Congratulations!
 I see you made it to the second Playground! So how was it? Hope you did not lose your enthusiasm and curiosity. It took me about a year to understand all that __graphy__ stuff, so do not worry if you couldn't get it right away.
_ _ _
Anyways, it is time to play, learn and practice at the same time!

So, here is the case. Imagine there is an ambulance which is trying to get the hospital as soon as possible. You are a dispatcher, and the driver of the ambulance asks you to get him the shortest route to the hospital. There are a lot of traffic lights in a town, so it is very important to choose the right route and get to the hospital in time.
_ _ _
Click the play button at the bottom to let the algorithm solve this problem! It visualizes each step it takes, using yellow color to show the current path, and white color to show the current shortest path. Once the algorithm finds the best one, the ambulance will start driving this route to the hospital.
 
>The number on the traffic light is the time it requires to wait.
 
>By __clicking__ on the traffic light you can manually change the wait time of the light.

>You can also __randomize__ the time on the traffic lights to see how the algorithm works on different graphs.
_ _ _
 Hey, run the DFS Playground here!
 */
PlaygroundPage.current.liveView = dfsVC
