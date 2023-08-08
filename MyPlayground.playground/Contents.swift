//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

let input = ["1", "3", "sasa"]
let numbers = input.compactMap{Int($0)}
print (numbers)
