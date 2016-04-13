//
//  KLEmojiViewController.swift
//  KLEmojiViewExample
//
//  Created by bcmac3 on 16/4/6.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

import UIKit

private let KLEmoticonCellReuseIdentifier = "KLEmoticonCellReuseIdentifier"

class KLEmoticonViewController: UIViewController {

    var emoticonDidSelectedCallBack: (emoticon: KLEmoticon) -> ()
    
    init(callBack: (emoticon: KLEmoticon) -> ())
    {
        self.emoticonDidSelectedCallBack = callBack
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.redColor()
        
        // 1.初始化UI
        setupUI()
    }
    
    private func setupUI(){
        // 1. 添加子控制器
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        // 2. 布局子控制器
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        var cons = [NSLayoutConstraint]()
        let dict = ["collectionView": collectionView, "toolBar": toolBar]
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[toolBar]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionView]-[toolBar(44)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        
        view.addConstraints(cons)
        // 初始化工具条
        setupToolbar()
    }
    
    private func setupToolbar(){
        
        toolBar.tintColor = UIColor.darkGrayColor()
        
        var items = [UIBarButtonItem]()
        var index = 0
        for s in ["最近", "默认", "emoji", "浪小花"]
        {
            let item = UIBarButtonItem(title: s, style: UIBarButtonItemStyle.Plain, target: self, action: "itemClick:")
            item.tag = index++
            items.append(item)
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolBar.items = items
    }
    
    func itemClick(item: UIBarButtonItem)
    {
        print(item.tag)
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: item.tag), atScrollPosition: .Left, animated: true)
    }

    // MARK: -- 懒加载
    private lazy var collectionView: UICollectionView = {
        let clv = UICollectionView(frame: CGRectZero, collectionViewLayout: KLEmoticonLayout())
        clv.registerClass(KLEmoticonCell.self, forCellWithReuseIdentifier: KLEmoticonCellReuseIdentifier)
        clv.dataSource = self
        clv.delegate = self
        return clv
    }()
    private lazy var toolBar: UIToolbar = UIToolbar()
    private lazy var packages: [KLEmoticonPackage] = KLEmoticonPackage.packageList
}

extension KLEmoticonViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return packages.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages[section].emoticons!.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(KLEmoticonCellReuseIdentifier, forIndexPath: indexPath) as! KLEmoticonCell
        
        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.redColor() : UIColor.greenColor()
        
        cell.emoticon = packages[indexPath.section].emoticons![indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let emoticon = packages[indexPath.section].emoticons![indexPath.item]
        // 判断表情符号是否有效
        if indexPath.section != 0 && emoticon.chs != nil || emoticon.emoji != nil
        {
            emoticon.times++
            // 将表情添加到 `最近的` emoticons 数组
            packages[0].addFavoriteEmoticon(emoticon)
            
        }
        emoticonDidSelectedCallBack(emoticon: emoticon)
    }
}

/// 自定义Cell
class KLEmoticonCell: UICollectionViewCell
{
    var emoticon:KLEmoticon?
        {
            didSet{
                // 1.设置图片
                if let path = emoticon!.imagePath{
                    emoticonBtn.setImage(UIImage(named: path), forState: UIControlState.Normal)
                }else
                {
                    // 防止重用
                    emoticonBtn.setImage(nil, forState: .Normal)
                }
                emoticonBtn.setTitle(emoticon!.emoji ?? "", forState: .Normal)
                
                // 设置删除按钮
                if emoticon!.removeButton {
                    emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
                    emoticonBtn.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
                }
            }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI()
    {
        contentView.addSubview(emoticonBtn)
        emoticonBtn.backgroundColor = UIColor.whiteColor()
        emoticonBtn.frame = CGRectInset(contentView.bounds, 4, 4)
    }
    
    // MARK: -- 懒加载
    private lazy var emoticonBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFontOfSize(32)
        btn.userInteractionEnabled = false
        return btn
    }()
}

/// 自定义布局
class KLEmoticonLayout: UICollectionViewFlowLayout
{
    override func prepareLayout() {
        super.prepareLayout()
        
        let width = (collectionView?.bounds.width)! / 7
        itemSize = CGSize(width: width, height: width)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
        
        // 最好不要乘以0.5 因为会不准确
        let y = ((collectionView?.bounds.height)! - 3 * width) * 0.499999999
        collectionView?.contentInset = UIEdgeInsets(top: y, left: 0, bottom: y, right: 0)
    }
}
