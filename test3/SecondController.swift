//
//  SecondController.swift
//  test3
//
//  Created by Padow　Usmar on 2014/10/19.
//  Copyright (c) 2014年 Padow　Usmar. All rights reserved.
//



import UIKit
import Foundation
extension String {
    subscript (i: Int) -> String {
        return String(Array(self)[i])
    }
}
var data = NSMutableArray()
/*
public class adeleg: NSObject, NSStreamDelegate {
    public var inputStream: NSInputStream!
    public var outputStream: NSOutputStream!
    public func stream(stream: NSStream, handleEvent eventCode: NSStreamEvent) {
        println("stream event")
    }
}
class Connection4 {
    func connect() {

        println("connecting4...")
        var del : adeleg!
        //var inputStream: NSInputStream? =del.inputStream
        //var outputStream: NSOutputStream? = del.outputStream
        
        NSStream.getStreamsToHostWithName("localhost", port: 8443, inputStream: &del.inputStream, outputStream: &del.outputStream)
        
        inputStream?.delegate = self
        outputStream?.delegate = self
        
        self.inputStream?.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        self.outputStream?.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        outputStream?.open()
        inputStream?.open()

    }
    
}


class Connection3 : NSObject, NSStreamDelegate {//this one should work!
    private var inputStream: NSInputStream?
    private var outputStream: NSOutputStream?
    func connect() {
        println("connecting3...")
        
        NSStream.getStreamsToHostWithName("localhost", port: 8443, inputStream: &self.inputStream, outputStream: &self.outputStream)
        
        self.inputStream?.delegate = self
        self.outputStream?.delegate = self
        
        self.inputStream?.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        self.outputStream?.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        self.outputStream?.open()
        self.inputStream?.open()

    }
    
    func stream(theStream: NSStream, handleEvent streamEvent: NSStreamEvent) {
        println("stream event")
    }
}




class Connection2 : NSObject, NSStreamDelegate {
    let serverAddress: CFString = "localhost"
    let serverPort: UInt32 = 8443
    
    private var inputStream: NSInputStream!
    private var outputStream: NSOutputStream!
    func connect() {
        println("connecting2...")
        var inputStream: NSInputStream?
        var outputStream: NSOutputStream?
        
        var data: NSData = "".dataUsingEncoding(NSUTF8StringEncoding)!
        NSStream.getStreamsToHostWithName("localhost", port: 8443, inputStream: &inputStream, outputStream: &outputStream)
        
        inputStream?.delegate = self
        outputStream?.delegate = self
        
        inputStream?.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        outputStream?.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        outputStream?.open()
        inputStream?.open()
    }
    
    func stream(stream: NSStream, handleEvent eventCode: NSStreamEvent) {
        println("stream event")
    }
}

func StringContainsCharacterAtEnd(Needle:Character,Haystack:String)->Bool {
    var counter=0;
    for character in Haystack {
        if(character==Needle) {
            if(counter==countElements(Haystack)) {
                return true
            }
        }
    }
    return false
}
var Buffer="";
func OutputAndBuffer(Input: String) {
    var tmp = Buffer+Input
    Buffer=""
    let Arr = tmp.componentsSeparatedByString("\n")
    if(countElements(Arr)==1){
        if(StringContainsCharacterAtEnd("\n", tmp)) {
            println(Arr[0])
        }
    }
    for(var counter=0;counter<Arr.count-1;counter++) {
        println(Arr[counter])
    }
    Buffer=Arr[Arr.count-1]
    //println("buffer:"+Buffer)
}
*/


var sockcon = Connection()
public class Connection : NSObject, NSStreamDelegate {
    let serverAddress: CFString = "localhost"
    let serverPort: UInt32 = 8443
    
    public var inputStream: NSInputStream!
    public var outputStream: NSOutputStream!
    

    
    func connect() {
        println("connecting...")
        
        var readStream:  Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(nil, self.serverAddress, self.serverPort, &readStream, &writeStream)
        
        // Documentation suggests readStream and writeStream can be assumed to
        // be non-nil. If you believe otherwise, you can test if either is nil
        // and implement whatever error-handling you wish.
        
        self.inputStream = readStream!.takeRetainedValue()
        self.outputStream = writeStream!.takeRetainedValue()
        
        self.inputStream.delegate = self
        self.outputStream.delegate = self
        
        self.inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        self.outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        self.inputStream.open()
        self.outputStream.open()
    }
    
    
    public func stream(stream: NSStream, handleEvent eventCode: NSStreamEvent) {
        var data:NSMutableData = NSMutableData(length: 128)!
        switch (eventCode) {
        case NSStreamEvent.OpenCompleted:
            println("Opened connection")
        case NSStreamEvent.HasBytesAvailable:
            println("Data Recieved")
            var res = sockcon.inputStream?.read(UnsafeMutablePointer<UInt8>(data.mutableBytes), maxLength: 128)
            data.length=res!
            let newstring = NSString(data: data, encoding: NSUTF8StringEncoding)
            //var sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            //var sc: SecondController = sb.instantiateViewControllerWithIdentifier("Chat") as SecondController
            //var sc: SecondController = SecondController()
            Line=newstring!
            FirstClassFunction()
            println(newstring!)
        case NSStreamEvent.HasSpaceAvailable:
            println("Sending")
            
        case NSStreamEvent.ErrorOccurred:
            println("error")
        case NSStreamEvent.EndEncountered:
            println("Encounter Ended")
        default:
            println("default")
        }
    }
}
var FirstClassFunction:()->()={}
var Line:String=""//replacement for parameter to function, I could nto figure out how ot send a string to the First class function
public class SecondController: UIViewController,UITableViewDelegate, UITableViewDataSource{


    public func WriteLine() {
        data.addObject(Line)
        tv1.reloadData()
        //scrolls to the bottom
        let numberOfSections = tv1.numberOfSections()
        let numberOfRows = tv1.numberOfRowsInSection(numberOfSections-1)
        
        if numberOfRows > 0 {
            println(numberOfSections)
            let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
            tv1.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    @IBAction func btnTest() {
        FirstClassFunction=self.WriteLine
        sockcon.connect()
        //var con = Connection3()


        /*
        var inputStream: NSInputStream?
        var outputStream: NSOutputStream?
        var data: NSData = "".dataUsingEncoding(NSUTF8StringEncoding)!
        NSStream.getStreamsToHostWithName("localhost", port: 8443, inputStream: &inputStream, outputStream: &outputStream)
        outputStream?.open()
        inputStream?.open()
        //inputStream?.delegate
        var tester: Bool=false
        
        while(tester == false) {
            tester=inputStream!.hasBytesAvailable.boolValue
            println("in loop")
        }//wait for input
        
        //get input
        inputStream?.read(UnsafeMutablePointer<UInt8>(data.bytes), maxLength: data.length)
        var newstring : NSString = NSString.stringWithUTF8String(UnsafePointer<Int8>(data.bytes))
        println(newstring)
        
        
        data = "this is a test string".dataUsingEncoding(NSUTF8StringEncoding)!
        outputStream?.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
        */
    }
    // An NSStream delegate callback that's called when events happen on our
    // network stream.
    /*
    func stream(theStream: NSStream!, handleEvent streamEvent: NSStreamEvent) {
        var data: NSData = "".dataUsingEncoding(NSUTF8StringEncoding)!

        switch (streamEvent) {
        case NSStreamEvent.OpenCompleted:
            println("Opened connection")
        case NSStreamEvent.HasBytesAvailable:
            println("Data Recieved")
            sockcon.inputStream?.read(UnsafeMutablePointer<UInt8>(data.bytes), maxLength: data.length)
            //var newstring : NSString = NSString.stringWithUTF8String(UnsafePointer<Int8>(data.bytes))
            //var ns=NSString(UTF8String: <#UnsafePointer<Int8>#>(data.bytes))
            //println(newstring)
        case NSStreamEvent.HasSpaceAvailable:
            println("Sending")
            
        case NSStreamEvent.ErrorOccurred:
            println("error")
        case NSStreamEvent.EndEncountered:
            println("ignore")
        default:
            println("default")
        }
    }
    */
    /*
    public func ScokConn(Host: String,Port: String) {
        var readStream : CFReadStreamRef
        var writeStream: CFWriteStreamRef
        //CFStreamCreatePairWithSocketToHost(nil, "localhost" as CFStringRef, 80, readStream, writeStream);
        CFStreamCreatePairWithSocketToHost(alloc: kCFAllocatorDefault, host: "google.com", port: 80, readStream: readStream, writeStream: writeStream)
        inputStream = (NSInputStream *)readStream;
        outputStream = (NSOutputStream *)writeStream;    }
*/
    public func JoinIRC(Room: String) {
    //send('NICK', nick)
    //send('USER', nick, nick, nick, nick)
    //send('JOIN', '#c1')
    }
    @IBOutlet var t1 : UITextField!;
    
    @IBOutlet var tv1 : UITableView!;
    
    
    
    @IBAction func BtnTouchSend(mybutton: UIButton) {
        //var Line : String;
        Line=t1.text
        WriteLine()
        //send data to server
        Line=Line+"\n"
        var data = NSData()
        data = Line.dataUsingEncoding(NSUTF8StringEncoding)!
        sockcon.outputStream?.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length)
        t1.text=""
    }
    
    //UITableDatasource
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
        
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "empty")
        cell.textLabel.text=data[indexPath.row] as? String
        return cell
    }

   
}
