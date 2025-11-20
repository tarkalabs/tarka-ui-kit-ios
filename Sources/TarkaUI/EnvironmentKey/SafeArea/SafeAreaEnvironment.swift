//
//  SafeAreaEnvironment.swift
//  EAM360
//
//  Created by Gopinath on 20/11/25.
//  Copyright © 2025 Sedin Technologies. All rights reserved.
//

import SwiftUI

private struct SafeAreaKey: EnvironmentKey {
    static let defaultValue: EdgeInsets = .init()
}

public extension EnvironmentValues {
  var tuiSafeAreaInsets: EdgeInsets {
    get { self[SafeAreaKey.self] }
    set { self[SafeAreaKey.self] = newValue }
  }
}
