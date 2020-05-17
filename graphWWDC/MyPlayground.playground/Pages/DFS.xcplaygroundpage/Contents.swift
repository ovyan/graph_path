//: A UIKit based Playground for presenting user interface

import Foundation
import PlaygroundSupport
import UIKit

let a = MyViewController()
a.preferredContentSize = a.view.frame.size
PlaygroundPage.current.liveView = a
