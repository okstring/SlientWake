//
//  ServiceProvider.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/06/05.
//

import Foundation

protocol ServiceProviderType: AnyObject {
    var alarmPlayerService: AlarmPlayerServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var alarmPlayerService: AlarmPlayerServiceType = AlarmPlayerService(provider: self)
}
