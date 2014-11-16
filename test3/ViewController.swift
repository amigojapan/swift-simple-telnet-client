//
//  ViewController.swift
//  test3
//
//  Created by Padow　Usmar on 2014/10/19.
//  Copyright (c) 2014年 Padow　Usmar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var l1 : UILabel!;
    @IBOutlet var t1 : UITextField!;
    
    @IBOutlet var t2 : UITextField!;
    
    //@IBOutlet var b1 : UIButton!;
    
    //@IBOutlet var v1 : UIViewController!;
   
    //@IBOutlet var v2 : UIViewController!;
    @IBAction func buttonOkTouched(sender : AnyObject) {
        l1.text="Welcome "+t1.text+"!";
    }
    /*
    @IBAction func buttonAboutTouched(sender : AnyObject) {
    //let vc = self.storyboard.instantiateViewControllerWithIdentifier("billInfo") as BillInfoViewController
    self.presentViewController(vc, animated: true, completion: nil)
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

