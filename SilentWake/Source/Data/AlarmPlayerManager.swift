//
//  AlarmPlayerManager.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/05/30.
//

import AVFoundation
import Foundation

protocol AlarmPlayerManagerProtocol {
    static var shared: AlarmPlayerManagerProtocol { get }

    func setAlarm(of type: AlarmType) throws
    func play()
}

class AlarmPlayerManager: AlarmPlayerManagerProtocol {
    var player: AVAudioPlayer?

    static var shared: AlarmPlayerManagerProtocol = AlarmPlayerManager()

    private init() { }

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
