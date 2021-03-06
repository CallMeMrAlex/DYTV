//
//  FunnyViewModel.swift
//  DYTV-AlexanderZ-Swift
//
//  Created by Alexander Zou on 2016/10/18.
//  Copyright © 2016年 Alexander Zou. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
