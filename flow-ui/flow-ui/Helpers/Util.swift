//
//  Util.swift
//  flow-ui
//
//  Created by Alp Keser on 19.04.2020.
//  Copyright © 2020 Alp Keser. All rights reserved.
//

import Foundation

extension TimeInterval {
    var asCounterFormattedText: String {
        let minutes = String(format: "%02d", Int(self) / 60)
        let seconds = String(format: "%02d", Int(self) % 60)
        return "\(minutes):\(seconds)"
    }
}
