//
//  ViewController.swift
//  ButtonsList
//
//  Created by Sasaki Akira on 2015/01/31.
//  Copyright (c) 2015年 Sasaki Akira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // window size
    class WindowSize {
        var size = UIScreen.mainScreen().applicationFrame.size;
        let width = UIScreen.mainScreen().applicationFrame.size.width;
        let height = UIScreen.mainScreen().applicationFrame.size.height;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var ws: WindowSize = WindowSize()
        
        var nButtons = 10 ////// the number of all buttons
        var nShowButtons = 6 // the number of showing buttons on the display
        var showInterval = 2 // [pixel]
        let size: CGFloat = ws.height / CGFloat(nShowButtons);
        
        for i in 0 ... nButtons-1 {
            var x1: CGFloat = 0;
            var y1: CGFloat = size * CGFloat(i)
            //var y2: CGFloat = y1 + size
            putButton(x1, y0: y1, width: ws.width, height: size, i)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    func putButton(x0:CGFloat, y0:CGFloat, width:CGFloat, height:CGFloat, tag:CGFloat) {
        NSLog("\(x0), \(y0), \(width), \(height)")
        
        let myButton: UIButton = UIButton()
        
        // サイズを設定する.
        myButton.frame = CGRectMake(x0, y0, width, height)
        
        // 背景色を設定する.
        myButton.backgroundColor = UIColor.blueColor()
        
        // 枠を丸くする.
        myButton.layer.masksToBounds = true
        
        // タイトルを設定する(通常時).
        myButton.setTitle("\(x0), \(y0)", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        // タイトルを設定する(ボタンがハイライトされた時).
        myButton.setTitle("ボタン(押された時)", forState: UIControlState.Highlighted)
        myButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        
        // コーナーの半径を設定する.
        myButton.layer.cornerRadius = 2.0
        
        // ボタンの位置を指定する.
        //myButton.layer.position = CGPoint(x: 0, y:0)
        
        // タグを設定する.
        myButton.tag = tag
        
        // イベントを追加する.
        //myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // ボタンをViewに追加する.
        self.view.addSubview(myButton)
    }

}
