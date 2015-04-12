//
//  BrowserViewController.swift
//  TransientWatch
//
//  Created by naoto yamaguchi on 2015/04/12.
//  Copyright (c) 2015年 naoto yamaguchi. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController, NJKWebViewProgressDelegate, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var url: NSURL?
    var proxy = NJKWebViewProgress()
    var progressView = NJKWebViewProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 
        CGFloat progressBarHeight = 2.5f;
        CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        
        //色を変えるには、[_progressView・・・]の下に下記の行を追加する事で変更可能です。ここでは赤にしていますが、何色でも可能です。
        */
        let h = 3.5
        let navbarBounds = self.navigationController?.navigationBar.bounds
        let frame = CGRectMake(0, 44.0 - CGFloat(h), CGRectGetWidth(self.view.frame), CGFloat(h))
        self.progressView =  NJKWebViewProgressView(frame: frame)
        
        self.proxy = NJKWebViewProgress()
        self.webView.delegate = self.proxy
        self.proxy.webViewProxyDelegate = self
        self.proxy.progressDelegate = self
        
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.setBackgroundImage(
            UIImage(),
            forBarMetrics: UIBarMetrics.DefaultPrompt
        )
        
        self.view.backgroundColor = UIColor.clearColor()
        self.webView.backgroundColor = UIColor.clearColor()
        let backGroundImage = UIImage(named: "BackGround")
        let imageView = UIImageView(image: backGroundImage)
        imageView.frame = self.view.bounds
        self.navigationController?.view.insertSubview(imageView, atIndex: 0)
        
        if let url = self.url {
            let request = NSURLRequest(URL: url)
            self.webView.loadRequest(request)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.webView.loading {
            self.webView.stopLoading()
            SVProgressHUD.dismiss()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIWebViewDelegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        SVProgressHUD.dismiss()
    }
    
    // MARK: - NJKWebViewProgressDelegate
    
    func webViewProgress(webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        self.progressView.progress = progress
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
