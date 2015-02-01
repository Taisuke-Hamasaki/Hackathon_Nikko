//
//  ViewController.swift
//  CoreLocation004
//

import UIKit
import CoreLocation

class BeaconIO: UIViewController,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{
    
    //window
    let myWindow = UIWindow()
    
    
    var myLocationManager:CLLocationManager!
    var myBeaconRegion:CLBeaconRegion!
    var myTableView: UITableView!
    var myIds: NSMutableArray!
    var myUuids: NSMutableArray!
    var isDisplayStationView: Bool!
    var isDisplayBusView: Bool!
    var myButtonNext: UIButton!
    var DEBUG: Bool!

    
    let myButton: UIButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DEBUG = true;
        
        // ロケーションマネージャの作成.
        myLocationManager = CLLocationManager()
        
        // デリゲートを自身に設定.
        myLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if(status == CLAuthorizationStatus.NotDetermined) {
            
            // まだ承認が得られていない場合は、認証ダイアログを表示
            self.myLocationManager.requestAlwaysAuthorization();
        }
        
        // BeaconのUUIDを設定.
        let uuid:NSUUID? = NSUUID(UUIDString: "CB86BC31-05BD-40CC-903D-1C9BD13D966A")
        
        // BeaconのIfentifierを設定.
        let identifierStr:NSString = "akabeacon"
        
        // リージョンを作成.
        myBeaconRegion = CLBeaconRegion(proximityUUID:uuid, identifier:identifierStr)
        
        // ディスプレイがOffでもイベントが通知されるように設定(trueにするとディスプレイがOnの時だけ反応).
        myBeaconRegion.notifyEntryStateOnDisplay = false
        
        // 入域通知の設定.
        myBeaconRegion.notifyOnEntry = true
        
        // 退域通知の設定.
        myBeaconRegion.notifyOnExit = true
        
        // 配列をリセット
        myIds = NSMutableArray()
        myUuids = NSMutableArray()
        
        // Status Barの高さを取得.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        //self.view.addSubview(myTableView)
        
        
     //UIntに16進で数値をいれるとUIColorが戻る関数
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
//こんな感じで利用します。
view.backgroundColor = UIColorFromRGB(0x339999)
        if(DEBUG == true){
        // ボタンの生成する.
        myButtonNext = UIButton(frame: CGRectMake(0,0,120,50))
        myButtonNext.backgroundColor = UIColor.blueColor();
        myButtonNext.layer.masksToBounds = true
        myButtonNext.setTitle("Next", forState: .Normal)
        myButtonNext.layer.cornerRadius = 20.0
        myButtonNext.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        myButtonNext.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // ボタンを追加する.
        self.view.addSubview(myButtonNext);
        }
        if(DEBUG == false){
                //super.viewDidLoad()
                
                // UIImageViewを作成する.
                let myImageView: UIImageView = UIImageView(frame: CGRectMake(0,0,180,240))
                
                // 表示する画像を設定する.
                let myImage = UIImage(named: "title_img.png")
                
                // 画像をUIImageViewに設定する.
                myImageView.image = myImage
                
                // 画像の表示する座標を指定する.
                myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: 300.0)
                
                // UIImageViewをViewに追加する.
                self.view.addSubview(myImageView)
        }
        
    }
    
   
    /*
    (Delegate) 認証のステータスがかわったら呼び出される.
    */
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        println("didChangeAuthorizationStatus");
        
        // 認証のステータスをログで表示
        var statusStr = "";
        switch (status) {
        case .NotDetermined:
            statusStr = "NotDetermined"
        case .Restricted:
            statusStr = "Restricted"
        case .Denied:
            statusStr = "Denied"
        case .Authorized:
            statusStr = "Authorized"
        case .AuthorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
        }
        println(" CLAuthorizationStatus: \(statusStr)")
        
        manager.startMonitoringForRegion(myBeaconRegion);
    }
    
    /*
    STEP2(Delegate): LocationManagerがモニタリングを開始したというイベントを受け取る.
    */
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion) {
        
        println("didStartMonitoringForRegion");
        
        // STEP3: この時点でビーコンがすでにRegion内に入っている可能性があるので、その問い合わせを行う
        // (Delegate didDetermineStateが呼ばれる: STEP4)
        manager.requestStateForRegion(myBeaconRegion);
    }
    
    /*
    STEP4(Delegate): 現在リージョン内にいるかどうかの通知を受け取る.
    
    　バスが近づいてきたとき
    　バス停に入ってきたとき
    */
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion inRegion: CLRegion!) {
        
        println("locationManager: didDetermineState \(state)");
        //println("***************");
        
        switch (state) {
            
        case .Inside: // リージョン内にいる
            println("CLRegionStateInside:");
            
            //self.view.addSubview(myButton)
            //println("*************");
            
            // STEP5: すでに入っている場合は、そのままRangingをスタートさせる
            // (Delegate didRangeBeacons: STEP6)
            manager.startRangingBeaconsInRegion(myBeaconRegion);
            //println("&&&&&&&&&&&&&&");
            break;
            
        case .Outside:
            println("CLRegionStateOutside:");
            // 外にいる、またはUknownの場合はdidEnterRegionが適切な範囲内に入った時に呼ばれるため処理なし。
            break;
            
        case .Unknown:
            println("CLRegionStateUnknown:");
            // 外にいる、またはUknownの場合はdidEnterRegionが適切な範囲内に入った時に呼ばれるため処理なし。
        default:
            
            break;
            
        }
    }
    
    /*
    STEP6(Delegate): ビーコンがリージョン内に入り、その中のビーコンをNSArrayで渡される.
    */
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: NSArray!, inRegion region: CLBeaconRegion!) {
        
        // 配列をリセット
        myIds = NSMutableArray()
        myUuids = NSMutableArray()
        
        // 範囲内で検知されたビーコンはこのbeaconsにCLBeaconオブジェクトとして格納される
        // rangingが開始されると１秒毎に呼ばれるため、beaconがある場合のみ処理をするようにすること.
        if(beacons.count > 0){
            
            // STEP7: 発見したBeaconの数だけLoopをまわす
            for var i = 0; i < beacons.count; i++ {
                
                var beacon = beacons[i] as CLBeacon
                
                let beaconUUID = beacon.proximityUUID;
                let minorID = beacon.minor;
                let majorID = beacon.major;
                let rssi = beacon.rssi;
                
                println("UUID: \(beaconUUID.UUIDString)");
                println("minorID: \(minorID)");
                println("majorID: \(majorID)");
                println("RSSI: \(rssi)");
                
                var proximity = ""
                
                if(minorID == 1){
                    isDisplayBusView = true
                    //self.view.addSubview(myButton)
                    // 遷移するViewを定義する.
                    let mySecondViewController: UIViewController = ListView()
                    
                    // アニメーションを設定する.
                    mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
                    
                    // Viewの移動する.
                    self.presentViewController(mySecondViewController, animated: true, completion: nil)
                }
                
                switch (beacon.proximity) {
                case CLProximity.Unknown:
                    println("Proximity: Unknown");
                    proximity = "Unknown"
                    break;
                    
                case CLProximity.Far:
                    println("Proximity: Far");
                    proximity = "Far"
                    break;
                    
                case CLProximity.Near:
                    println("Proximity: Near");
                    proximity = "Near"
                    break;
                    
                case CLProximity.Immediate:
                    println("Proximity: Immediate");
                    proximity = "Immediate"
                    break;
                }
                
                
                let myBeaconId = "MajorId: \(majorID) MinorId: \(minorID)  RSSI:\(rssi) Proximity:\(proximity)"
                myIds.addObject(myBeaconId)
                myUuids.addObject(beaconUUID.UUIDString)
                myTableView.reloadData()
                
            }
        }
    }
    
    /*
    (Delegate) リージョン内に入ったというイベントを受け取る.
    */
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("didEnterRegion");
        println("++++++++++++++++++");
        //makeMyWindow()
        
        
        //画像読み込み
        /*
        var imagePath: String {
        let doc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        return doc.stringByAppendingPathComponent("ibeacon.png")
        }
        
        let image = UIImage(contentsOfFile: imagePath)
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(0, 150, 400, 400)
        self.view .addSubview(imageView)
        
        */
        
        // Rangingを始める
        manager.startRangingBeaconsInRegion(myBeaconRegion);
        
    }
    
    /*
    (Delegate) リージョンから出たというイベントを受け取る.
    */
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        NSLog("didExitRegion");
        println("================");
        
        // Rangingを停止する
        manager.stopRangingBeaconsInRegion(myBeaconRegion);
    }
    
    /*
    Cellが選択された際に呼び出される
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Num: \(indexPath.row)")
        println("myIds: \(myIds[indexPath.row])")
        println("myUuids: \(myUuids[indexPath.row])")
        
    }
    /*
    Cellの総数を返す
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myIds.count
    }
    
    /*
    Cellに値を設定する
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier:"MyCell" )
        
        // Cellに値を設定
        cell?.textLabel?.sizeToFit()
        cell?.textLabel?.textColor = UIColor.blueColor()
        cell?.textLabel?.text = "\(myIds[indexPath.row])"
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        
        // Cellに値を設定(下)
        cell?.detailTextLabel?.text = "\(myUuids[indexPath.row])"
        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(12)
        
        return cell!
    }
    
    //ビーコン受信時に出す表示関数 未使用
    func makeMyWindow(){
        
        
        
        // 背景を白に設定
        myWindow.backgroundColor = UIColor.lightGrayColor()
        myWindow.frame = CGRectMake(0, 0, self.view.bounds.width - 50, self.view.bounds.height - 150)
        myWindow.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        myWindow.alpha = 0.8
        myWindow.layer.cornerRadius = 30
        myWindow.layer.borderColor = UIColor.blackColor().CGColor
        myWindow.layer.borderWidth = 2
        // myWindowをkeyWindowにする
        myWindow.makeKeyWindow()
        
        // windowを表示する
        self.myWindow.makeKeyAndVisible()
        
        // 表示する画像.
        let myImage: UIImage = UIImage(named: "logo.png")!
        let myImageView: UIImageView = UIImageView(frame:  CGRect(x: self.myWindow.frame.width/2 - 60, y: 5, width: 100, height: 100))
        myImageView.image = myImage
        self.myWindow.addSubview(myImageView)
        
    }
    
    
    
    //
    // ボタンイベント
    //
    func onClickMyButton(sender: UIButton){
        
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = ListView()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
        
    }
}