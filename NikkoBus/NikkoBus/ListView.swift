//
//  ViewController.swift
//  ButtonsList
//
//  Created by Sasaki Akira on 2015/01/31.
//  Copyright (c) 2015年 Sasaki Akira. All rights reserved.
//

import UIKit

class ListView: UIViewController {
    
    var ws: WindowSize = WindowSize()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //var ws = WindowSize()
        var nButtons: CGFloat = 10 ////// the number of all buttons
        var nShowButtons: CGFloat = 6 // the number of showing buttons on the display
        var interval: CGFloat = 2 // [pixel]
        let size: CGFloat = 100 //ws.height / nShowButtons
        var yStart = size + interval
        
        var yy0 = yStart;
        for i in 0 ... Int(nButtons)-1{
            var x1: CGFloat = interval
            yy0 = yy0 + size;
            //var y1: CGFloat = size * CGFloat(i)
            //var y2: CGFloat = y1 + size
            putButton(x1, y0: yy0, width: ws.width, height: size, tag: i)
            putCircleButton(x1, y0: yy0, width: ws.width, height: size, tag: i)
            
            yy0 = yy0 + interval;
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func putTextView(x0:CGFloat, y0:CGFloat, width:CGFloat, height:CGFloat, tag:Int) {
        // Labelを作成.
        let myLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
        
        // 背景をオレンジ色にする.
        myLabel.backgroundColor = UIColor.orangeColor()
        
        // 枠を丸くする.
        myLabel.layer.masksToBounds = true
        
        // コーナーの半径.
        myLabel.layer.cornerRadius = 20.0
        
        // Labelに文字を代入.
        myLabel.text = "Hello Swift!!"
        
        // 文字の色を白にする.
        myLabel.textColor = UIColor.whiteColor()
        
        // 文字の影の色をグレーにする.
        myLabel.shadowColor = UIColor.grayColor()
        
        // Textを中央寄せにする.
        myLabel.textAlignment = NSTextAlignment.Center
        
        // 配置する座標を設定する.
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        
        // Viewの背景色を青にする.
        self.view.backgroundColor = UIColor.cyanColor()
        
        // ViewにLabelを追加.
        self.view.addSubview(myLabel)
    }
    
    func putButton(x0:CGFloat, y0:CGFloat, width:CGFloat, height:CGFloat, tag:Int) {
        NSLog("\(x0), \(y0), \(width), \(height)")
        
        let myButton: UIButton = UIButton()
        
        // サイズを設定する.
        myButton.frame = CGRectMake(x0, y0, width, height)
        
        // 背景色を設定する.
        myButton.backgroundColor = UIColor.blueColor()
        
        // mySystemButtonに枠を追加する.
        //myButton.frame = CGRectMake(x0, y0, width, height)
        
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
    
    
    // ボタンを定義.
    let myInfoDarkButton: UIButton = UIButton.buttonWithType(UIButtonType.InfoDark) as UIButton
    //let myInfoLightButton: UIButton = UIButton.buttonWithType(UIButtonType.InfoLight) as UIButton
    //let myAddButton: UIButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
    //let myDetailButton: UIButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    //let mySystemButton: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    
    func putCircleButton(x0:CGFloat, y0:CGFloat, width:CGFloat, height:CGFloat, tag:Int) {
        NSLog("\(x0), \(y0), \(width), \(height)")
        
        // ボタンの位置を指定する.
        myInfoDarkButton.layer.position = CGPoint(x: x0, y: y0)
        //myInfoLightButton.layer.position = CGPoint(x: self.view.frame.width/2, y:100)
        //myAddButton.layer.position = CGPoint(x: self.view.frame.width/2, y:150)
        //myDetailButton.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        
        // mySystemButtonに枠を追加する.
        //mySystemButton.frame = CGRectMake(0, 0, 200, 50)
        
        // mySystemButtonの位置を設定する.
        //mySystemButton.layer.position = CGPoint(x: self.view.frame.width/2, y:250)
        
        // mySystemButtonにタイトルを設定する.
        //mySystemButton.setTitle("mySystemButton", forState: UIControlState.Normal)
        
        // タグを設定する.
        myInfoDarkButton.tag = 1
        //myInfoLightButton.tag = 2
        //myAddButton.tag = 3
        //myDetailButton.tag = 4
        //mySystemButton.tag = 5
        
        // イベントを追加する.
        ////myInfoDarkButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        //myInfoLightButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        //myAddButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        //myDetailButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        //mySystemButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // ボタンをViewに追加する.
        self.view.addSubview(myInfoDarkButton)
        //self.view.addSubview(myInfoLightButton)
        //self.view.addSubview(myAddButton)
        //self.view.addSubview(myDetailButton)
        //self.view.addSubview(mySystemButton)
    }
    
    func putImage(filename: NSSting : UIImageView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        // UIImageViewを作成する.
        let myImageView: UIImageView = UIImageView(frame: CGRectMake(x, y, width, height))
        
        // 表示する画像を設定する.
        let myImage = UIImage(named: filename)
        
        // 画像をUIImageViewに設定する.
        myImageView.image = myImage
        
        // 画像の表示する座標を指定する.
        //myImageView.layer.position = CGPoint(x: x, y: y)
        
        // UIImageViewをViewに追加する.
        self.view.addSubview(myImageView)
        
    }
    
}
