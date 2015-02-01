//
//  ViewController.swift
//  ButtonsList
//
//  Created by Sasaki Akira on 2015/01/31.
//  Copyright (c) 2015年 Sasaki Akira. All rights reserved.
//

import UIKit

class ListView: UIViewController {
    
    let myWindow = UIWindow()
    let myWindowButton = UIButton()
    
    var ws: WindowSize = WindowSize()
    
    
    var busStations: [NSString] =
      [ "Tobu Nikko",
        "Ishiya-machi",
        "Goko-machi",
        "Nikko yodosentamae",
        "Shinkyo",
        "Nishisando",
        "Nikko Botanical Garden"]
    
    var busIconNames: [NSString] =
      [ "",
        "",
        ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Background Color
        view.backgroundColor = UIColor.whiteColor()
        
        //var ws = WindowSize()
        var nButtons: CGFloat = CGFloat(busStations.count) ////// the number of all buttons
        var nShowButtons: CGFloat = 6 // the number of showing buttons on the display
        var interval: CGFloat = 2 // [pixel]
        let size: CGFloat = ws.height / nShowButtons
        var yStart = size + interval
        
        var iconSize:CGFloat = size * (3/5);
        var iconX0: CGFloat = 2;
        
        putImage("currentBusStation", x: 0-25, y: 0, width: ws.width*1.44, height: yStart-1)
        //putImage("currentBusStop", x: iconX0, y: (size-iconSize)/2, width: iconSize, height: iconSize)
        var yy0 = yStart;
        for i in 0 ... Int(nButtons)-1{
            var x0: CGFloat = interval
            //var y1: CGFloat = size * CGFloat(i)
            //var y2: CGFloat = y1 + size
            putButton(busStations[i], x0:x0, y0: yy0, width: ws.width, height: size, tag: i)
            //putCircleButton(x0, y0: yy0, width: ws.width, height: size, tag: i)
            
            putImage("busStop", x: iconX0, y: yy0+(size-iconSize)/2, width: iconSize*(4/5), height: iconSize)
            if i == 3 {
                putImageButton("shrine", x: iconX0, y: yy0+(size-iconSize)/2, width: iconSize, height: iconSize, tag: i+1000)
                
                //putImageButton(filename: NSString, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, tag: Int) {
                    

            }
            yy0 = yy0 + size + interval;
//            yy0 = yy0 + interval;
            
        
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
    
    func putButton(str: NSString, x0:CGFloat, y0:CGFloat, width:CGFloat, height:CGFloat, tag:Int) {
        NSLog("\(x0), \(y0), \(width), \(height)")
        
        let myButton: UIButton = UIButton()
        
        // サイズを設定する.
        myButton.frame = CGRectMake(x0, y0, width, height)
        
        // 背景色を設定する.
        myButton.backgroundColor = UIColor.cyanColor()
        
        // mySystemButtonに枠を追加する.
        //myButton.frame = CGRectMake(x0, y0, width, height)
        
        // 枠を丸くする.
        myButton.layer.masksToBounds = true
        
        // タイトルを設定する(通常時).
        myButton.setTitle(str, forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

        
        // タイトルを設定する(ボタンがハイライトされた時).
        myButton.setTitle(str, forState: UIControlState.Highlighted)
        myButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Highlighted)
        
        // コーナーの半径を設定する.
        myButton.layer.cornerRadius = 2.0
        
        // ボタンの位置を指定する.
        //myButton.layer.position = CGPoint(x: 0, y:0)
        
        // タグを設定する.
        myButton.tag = tag
        
        myButton.titleLabel!.font = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
        myButton.titleLabel!.font = UIFont.systemFontOfSize(CGFloat(24))
        
        /*
        // カスタムしたフォントサイズ(20)の文字列を..ラベルに表示する.
        let myCustomLabel: UILabel = UILabel()
        myButton.font = UIFont.systemFontOfSize(CGFloat(20))
        //myCustomLabel.text = "ポイント20のフォントサイズ"
        //myCustomLabel.frame = CGRect(x: 25, y: 90, width: 300, height: 150)
        
        let myBoldLabel: UILabel = UILabel()
        myBoldLabel.font = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
        myBoldLabel.text = "Boldフォント"
        myBoldLabel.frame = CGRect(x: 25, y: 180, width: 300, height: 150)
        self.view.addSubview(myBoldLabel)
        */
        
        // イベントを追加する.
        if tag == 3 {
            var iconSize: CGFloat = height;
            putImage("shrine", x: ws.width-iconSize, y: y0, width: iconSize, height: iconSize)
            myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        }
        
        // ボタンをViewに追加する.
        self.view.addSubview(myButton)
    }
    
    
    func putImage(filename: NSString, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
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
    
    func putImageButton(filename: NSString, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, tag: Int) {
    
    let image = UIImage(named: filename)
    let imageButton   = UIButton()
    imageButton.tag = tag
    imageButton.frame = CGRectMake(0, 0, width, height)
    //imageButton.layer.position = CGPoint(x: self.view.frame.width/2, y:450)
    imageButton.setImage(image, forState: .Normal)
    
    imageButton.addTarget(self, action: "onClickInfo:", forControlEvents:.TouchUpInside)
    self.view.addSubview(imageButton)
    
        /*
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
    */
    }

    
    
    /*
    自作Windowを生成する
    */
    func makeMyWindow(){
        
        // 背景を白に設定する.
        myWindow.backgroundColor = UIColor.whiteColor()
        myWindow.frame = CGRectMake(0, 0, 200, 250)
        myWindow.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        myWindow.alpha = 0.8
        myWindow.layer.cornerRadius = 20
        
        // myWindowをkeyWindowにする.
        myWindow.makeKeyWindow()
        
        // windowを表示する.
        self.myWindow.makeKeyAndVisible()
        
        // ボタンを作成する.
        myWindowButton.frame = CGRectMake(0, 0, 100, 60)
        myWindowButton.backgroundColor = UIColor.orangeColor()
        myWindowButton.setTitle("Close", forState: .Normal)
        myWindowButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myWindowButton.layer.masksToBounds = true
        myWindowButton.layer.cornerRadius = 20.0
        myWindowButton.layer.position = CGPointMake(self.myWindow.frame.width/2, self.myWindow.frame.height-50)
        myWindowButton.addTarget(self, action: "onClickMyInfo:", forControlEvents: .TouchUpInside)
        self.myWindow.addSubview(myWindowButton)
        
        // TextViewを作成する.
        let myTextView: UITextView = UITextView(frame: CGRectMake(10, 10, self.myWindow.frame.width - 20, 150))
        myTextView.backgroundColor = UIColor.clearColor()
        myTextView.text = "大内宿は、会津城下と下野の国（日光今市）を結ぶ32里の区間の中で会津から2番目の宿駅として1640年ごろに整備された宿場町です。"
        myTextView.font = UIFont.systemFontOfSize(CGFloat(15))
        myTextView.textColor = UIColor.blackColor()
        myTextView.textAlignment = NSTextAlignment.Left
        myTextView.editable = false
        
        self.myWindow.addSubview(myTextView)
    }
    
    
    
    
    
    // myButtonNext.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside) <-
    //
    // ボタンイベント
    //
    func onClickMyButton(sender: UIButton){
        
        // 遷移するViewを定義する.
        let myThirdViewController: UIViewController = WaitingBus()
        
        // アニメーションを設定する.
        myThirdViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(myThirdViewController, animated: true, completion: nil)
        
    }
    
    func onClickMyInfo(sender: UIButton) {
        //let myInfoViewController: UIViewController = InfoView()
        
        //myInfoViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        //self.presentViewController(myThirdViewController, animated: true, completion: nil)
        
        /*
        if sender == myWindowButton {
            myWindow.hidden = true
        } else {
            makeMyWindow()
        }
        */
        println("absdf")
        
    }
    
}
