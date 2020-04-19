//
//  StatsView.swift
//  flow-ui
//
//  Created by Alp Keser on 17.04.2020.
//  Copyright © 2020 Alp Keser. All rights reserved.
//

import Combine
import SwiftUI

struct StatsView: View {
    var hideOtherViews: Bool
    
    @ObservedObject var listener: StatsListener = StatsListener()
    var line: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 100, y: 0))
        }
        .stroke(Color.blue, lineWidth: 1)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            self.line.frame(width: 100, height: 1, alignment: .leading)
            Text("\(listener.stats.numberOfSessionsTitle)")
                
        })
        
    }
}

class StatsListener: Subscriber, ObservableObject {
    typealias Input = Int
    typealias Failure = Never
    @Published var stats = Stats()
    var subs: [Subscription] = []
    func receive(subscription: Subscription) {
        self.subs.append(subscription)
        subscription.request(.unlimited)
    }

    func receive(_ input: StatsListener.Input) -> Subscribers.Demand {
        print("State received: \(input)")
        stats.numberOfSessions += 1
        stats.totalTime += input
        return .unlimited
    }

    func receive(completion: Subscribers.Completion<StatsListener.Failure>) {
        
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(hideOtherViews: false)
            .frame(height: 1.0)
    }
}
