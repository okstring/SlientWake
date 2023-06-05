//
//  PlayerUseCase.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/06/05.
//

import Foundation

struct PlayerUseCase {
    let playerManager: AlarmPlayerManagerProtocol

    init(playerManager: AlarmPlayerManagerProtocol = AlarmPlayerManager.shared) {
        self.playerManager = playerManager
    }
}
