//
//  FlowStats.swift
//  flow-ui
//
//  Created by Alp Keser on 17.04.2020.
//  Copyright © 2020 Alp Keser. All rights reserved.
//

import Foundation
struct Stats {
    var numberOfSessions = 0
    var totalTime = 0
    
    var numberOfSessionsTitle: String {
        "\(numberOfSessions) Sessions"
    }
    
    var totalTimeTitle: String {
        let minutes = String(format: "%02d", totalTime / 60)
        let seconds = String(format: "%02d", totalTime % 60)
        return "\(minutes)m \(seconds)s"
    }
}
