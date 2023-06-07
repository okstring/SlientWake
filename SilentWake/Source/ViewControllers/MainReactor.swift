//
//  MainReactor.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/06/07.
//

import UIKit

import ReactorKit

class MainReactor: Reactor {
  // 사용자 작업을 나타냄
    enum Action {
        case touchButton(index: Int)
    }

  // 상태 변경을 나타냄
    enum Mutation {
        case setImage(image: UIImage?)
    }

  // 현재 View 상태를 나타냄
    struct State {
        var image: UIImage?
    }

    let initialState: State

    init() {
        self.initialState = State()
    }
}
