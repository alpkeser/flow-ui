//
//  Counter.swift
//  flow-ui
//
//  Created by Alp Keser on 17.04.2020.
//  Copyright © 2020 Alp Keser. All rights reserved.
//

import SwiftUI
import Combine

class Counter: ObservableObject {
    enum State {
        case ready
        case running
        case paused
        case finished
    }
    
    
    @Published public var timeLeft: String = ""
    @Published public var timeLeftValue: TimeInterval = 0
    
    @Published public var state: State {
        didSet {
            if state == .ready {
                stateChangePublisher.send(Int(self.sessionTime))
            }
        }
    }
    
    
    let stateChangePublisher = PassthroughSubject<Int, Never>()
    var sessionTime: TimeInterval
    var endDate: Date?
    var timer: Timer?
    
    public var counterRingTrimValue: CGFloat {
        switch state {
        case .ready:
            return 1
        case .running:
            return 0
        case .paused:
            return CGFloat(secondsLeft / totalSeconds)
        case .finished:
            return 1
        }
    }
    
    
    
    var secondsLeft: TimeInterval {
        return endDate?.timeIntervalSince(Date()) ?? totalSeconds
    }
    
    var totalSeconds: TimeInterval {
        sessionTime
    }
    
    var totalTimeInMinutes: Int {
        Int(sessionTime == 0 ? 0 : sessionTime / 60.0)
    }
    
    init(sessionTime: TimeInterval) {
        self.sessionTime = sessionTime
        state = .ready
        updateTimerText(with: self.totalSeconds)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    @objc func appMovedToBackground() {
        restart()
    }
    
    @objc func appCameToForeground() {
        updateTimerText(with: self.totalSeconds)
    }
    
    
    private func updateTimerText(with seconds: TimeInterval) {
        DispatchQueue.main.async {
            self.timeLeftValue = seconds
            self.timeLeft =  seconds.asCounterFormattedText
        }
    }
    
    func start() {
        if state == .paused {
            endDate = Date().addingTimeInterval(timeLeftValue)
        } else {
            endDate = Date().addingTimeInterval(totalSeconds)
        }
        
        state = .running
        self.updateTimerText(with: secondsLeft)
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
            guard let endDate = self.endDate else {
                self.restart()
                return
            }
            self.updateTimerText(with: self.secondsLeft)
            if Date().timeIntervalSince(endDate) > 0 {
                self.handleCounterFinish()
            }
        }
    }
    
    private func handleCounterFinish() {
        restart()
    }
    
    func restart() {
        self.timer?.invalidate()
        self.timer = nil
        state = .ready
        endDate = nil
        updateTimerText(with: self.totalSeconds)
    }
    
    func pause() {
        state = .paused
        self.timer?.invalidate()
    }
    
}
