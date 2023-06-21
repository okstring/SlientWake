//
//  BaseViewController.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/06/21.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
}

