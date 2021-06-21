//
//  TemperatureDialApp.swift
//  Shared
//
//  Created by Frank Cipolla on 6/7/21.
//

import SwiftUI

@main
struct TemperatureDialApp: App {
    var body: some Scene {
        WindowGroup {
            TemperatureDial(temperature: 100.0)
        }
    }
}
