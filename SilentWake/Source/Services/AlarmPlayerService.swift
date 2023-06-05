//
//  AlarmPlayerManager.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/05/30.
//

import AVFoundation
import Foundation

protocol AlarmPlayerServiceType {
    func setAlarm(of type: AlarmType) throws
    func play()
}

class AlarmPlayerService: BaseService, AlarmPlayerServiceType {
    var shared: AlarmPlayerManager {
        return AlarmPlayerManager.shared
    }

    func setAlarm(of type: AlarmType) throws {
        try shared.setAlarm(of: type)
    }

    func play() {
        shared.play()
    }
}

class AlarmPlayerManager {
    var player: AVAudioPlayer?

    static let shared = AlarmPlayerManager()

    func setAlarm(of type: AlarmType) throws {
        guard let alarmURL = type.alarmURL else {
            throw PlayerError(errorType: .invalidURL)
        }

        do {
            player = try AVAudioPlayer(contentsOf: alarmURL)
        } catch {
            throw PlayerError(errorType: .invalidURL)
        }

        player?.prepareToPlay()
    }

    func play() {
        player?.play()
    }
}
