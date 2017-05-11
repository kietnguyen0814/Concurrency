//
//  ViewController.swift
//  Concurrency
//
//  Created by Kiet Nguyen on 5/11/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageURLs = ["https://scontent.fsgn2-2.fna.fbcdn.net/v/t31.0-8/16722784_744552909039010_3385742667906076485_o.jpg?oh=7ccd1b16f04d0127972577a8106f6ab2&oe=59BA1C3E",
                     "https://scontent.fsgn2-2.fna.fbcdn.net/v/t1.0-9/15622622_717339701760331_7452167960282891748_n.jpg?oh=b200baea9136bbf337f449e69c7816fe&oe=59764C42",
                     "https://scontent.fsgn2-2.fna.fbcdn.net/v/t1.0-9/15032658_697799033714398_5127801277105636945_n.jpg?oh=c740a9cebe9879f0a13c4b9546fecc88&oe=5982ADAA",
                     "https://scontent.fsgn2-2.fna.fbcdn.net/v/t31.0-8/10631243_351976814963290_4348107661888867827_o.jpg?oh=c0e56df947e9ec4ff846c51d1c2dae72&oe=59B88D61"]
    
    class Downloader {
        
        class func downloadImageWithURL(_ url:String) -> UIImage! {
            
            let data = try? Data(contentsOf: URL(string: url)!)
            return UIImage(data: data!)
        }
    }
    

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    
    @IBOutlet weak var slideVaueLabel: UILabel!
    
    var queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Set Image Normal
    /*@IBAction func didClickOnStart(_ sender: AnyObject) {
     
     let img1 = Downloader.downloadImageWithURL(imageURLs[0])
     self.imageView1.image = img1
     
     let img2 = Downloader.downloadImageWithURL(imageURLs[1])
     self.imageView2.image = img2
     
     let img3 = Downloader.downloadImageWithURL(imageURLs[2])
     self.imageView3.image = img3
     
     let img4 = Downloader.downloadImageWithURL(imageURLs[3])
     self.imageView4.image = img4
     }*/
    
    //MARK: - Using Concurrent Dispatch Queues
    /*@IBAction func didClickOnStart(_ sender: AnyObject) {
     let queue = DispatchQueue.global(qos: .default)
     queue.async() { () -> Void in
     
     
     let img1 = Downloader.downloadImageWithURL(imageURLs[0])
     DispatchQueue.main.async(execute: {
     
     self.imageView1.image = img1
     })
     
     }
     queue.async() { () -> Void in
     
     let img2 = Downloader.downloadImageWithURL(imageURLs[1])
     
     DispatchQueue.main.async(execute: {
     
     self.imageView2.image = img2
     })
     
     }
     queue.async() { () -> Void in
     
     let img3 = Downloader.downloadImageWithURL(imageURLs[2])
     
     DispatchQueue.main.async(execute: {
     
     self.imageView3.image = img3
     })
     
     }
     queue.async() { () -> Void in
     
     let img4 = Downloader.downloadImageWithURL(imageURLs[3])
     
     DispatchQueue.main.async(execute: {
     
     self.imageView4.image = img4
     })
     }
     }*/
    
    //MARK: - Using Serial Dispatch Queues
    /*@IBAction func didClickOnStart(_ sender: AnyObject) {
     let serialQueue = DispatchQueue(label: "com.appcoda.imagesQueue")
     
     
     serialQueue.async() { () -> Void in
     
     let img1 = Downloader .downloadImageWithURL(imageURLs[0])
     DispatchQueue.main.async(execute: {
     
     self.imageView1.image = img1
     })
     
     }
     serialQueue.async() { () -> Void in
     
     let img2 = Downloader.downloadImageWithURL(imageURLs[1])
     
     DispatchQueue.main.async(execute: {
     
     self.imageView2.image = img2
     })
     
     }
     serialQueue.async() { () -> Void in
     
     let img3 = Downloader.downloadImageWithURL(imageURLs[2])
     
     DispatchQueue.main.async(execute: {
     
     self.imageView3.image = img3
     })
     
     }
     serialQueue.async() { () -> Void in
     
     let img4 = Downloader.downloadImageWithURL(imageURLs[3])
     
     DispatchQueue.main.async(execute: {
     
     self.imageView4.image = img4
     })
     }
     }*/
    //MARK: - NSOperationQueue
    @IBAction func didClickOnStart(_ sender: AnyObject){
        queue = OperationQueue()
        let operation1 = BlockOperation(block: {
            let img1 = Downloader.downloadImageWithURL(self.imageURLs[0])
            OperationQueue.main.addOperation({
                self.imageView1.image = img1
            })
        })
        
        operation1.completionBlock = {
            operation1.completionBlock = {
                print("Operation 1 completed, cancelled:\(operation1.isCancelled) ")
            }
        }
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {
            let img2 = Downloader.downloadImageWithURL(self.imageURLs[1])
            OperationQueue.main.addOperation({
                self.imageView2.image = img2
            })
        })
        
        operation2.completionBlock = {
            print("Operation 2 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation2)
        
        
        let operation3 = BlockOperation(block: {
            let img3 = Downloader.downloadImageWithURL(self.imageURLs[2])
            OperationQueue.main.addOperation({
                self.imageView3.image = img3
            })
        })
        
        operation3.completionBlock = {
            print("Operation 3 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation3)
        
        let operation4 = BlockOperation(block: {
            let img4 = Downloader.downloadImageWithURL(self.imageURLs[3])
            OperationQueue.main.addOperation({
                self.imageView4.image = img4
            })
        })
        
        operation4.completionBlock = {
            print("Operation 4 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation4)
        
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)
    }
    
    //MARK: - User Click On Cancel Button
    @IBAction func didClickOnCancel(sender: AnyObject) {
        
        self.queue.cancelAllOperations()
    }
    
    //MARK: - User Slide To Change Value
    @IBAction func sliderValueChanged(_ sender: UISlider){
        self.slideVaueLabel.text = "\(sender.value * 100.0)"
    }

}

