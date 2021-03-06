//
//  RecommendCycleView.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 16/10/10.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

private let kCycleID = "kCycleID"

class RecommendCycleView: UIView {
    
    var scrollTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            
            collectView.reloadData()
            
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            cancleTimer()
            addTimer()

        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        
        collectView.showsHorizontalScrollIndicator = false
        collectView.bounces = false
        collectView.dataSource = self
        collectView.delegate = self
        
        // 注册cell
        collectView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleID)
        
    }
    
    override func layoutSubviews() {
        
        
        // 设置layout
        let layout = collectView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectView.bounds.size
    }

}

extension RecommendCycleView {
    
    class func recommendCycleView() -> RecommendCycleView {
        
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)!.first as! RecommendCycleView
    }
    
}


// MARK:- 遵守collectionView数据源
extension RecommendCycleView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000  // *10000 返回足够多的cell来做无限滚动
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleID, for: indexPath as IndexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
    
}

// MARK:- 遵守collectionView代理
extension RecommendCycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5
        
        pageControl.currentPage = Int(offset / scrollView.bounds.size.width) % (cycleModels?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        cancleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
}


// MARK:- 添加定时器实现自动滚动
extension RecommendCycleView {
    
    fileprivate func addTimer() {
        
        scrollTimer = Timer(timeInterval: 2, target: self, selector: #selector(RecommendCycleView.scrollNext), userInfo: nil, repeats: true)
        
        // runloop设置
        RunLoop.main.add(scrollTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    @objc fileprivate func scrollNext() {
        
        let offset = collectView.contentOffset.x + collectView.bounds.width
        collectView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        
    }
    
    
    fileprivate func cancleTimer() {
        scrollTimer?.invalidate()
        scrollTimer = nil
    }
    
    
}
