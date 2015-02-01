//
//  WindowSize.swift
//  ButtonsList
//
//  Created by Sasaki Akira on 2015/01/31.
//  Copyright (c) 2015年 Sasaki Akira. All rights reserved.
//

import UIKit
import Foundation

// window size
class WindowSize {
    var width: CGFloat
    var height: CGFloat
    
    init() {
        var size = UIScreen.mainScreen().applicationFrame.size;
        width = UIScreen.mainScreen().applicationFrame.size.width;
        height = UIScreen.mainScreen().applicationFrame.size.height;
    }
}
