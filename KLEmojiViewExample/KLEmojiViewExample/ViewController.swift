//
//  ViewController.swift
//  KLEmojiViewExample
//
//  Created by bcmac3 on 16/4/6.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(emotionVC)
        
        textView.inputView = emotionVC.view
    }
    
    // MARK: -- 懒加载
    private lazy var emotionVC: KLEmoticonViewController = KLEmoticonViewController { [weak self] (emoticon) -> () in
        print(emoticon.chs)
        self!.textView.insertEmoticon(emoticon)
    }

}

