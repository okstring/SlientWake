//
//  BaseService.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/06/05.
//

import Foundation

class BaseService {
  unowned let provider: ServiceProviderType

  init(provider: ServiceProviderType) {
    self.provider = provider
  }
}
