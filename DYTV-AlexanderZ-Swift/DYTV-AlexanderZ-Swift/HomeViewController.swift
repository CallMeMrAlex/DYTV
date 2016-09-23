//
//  HomeViewController.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/9/23.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    
    // 懒加载属性
    private lazy var pageTitleView:PageTitleView = {
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, title: titles)
//        titleView.backgroundColor = UIColor.blueColor()
        return titleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension HomeViewController {
    
    private func setupUI() {
        
        // 不需要调整内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setNavBar()
        
        // 添加TitleView
        view.addSubview(pageTitleView)
        
    }
    
    
    private func setNavBar() {
        
        // 1.设置左边logo
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右边itme
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    
    
}