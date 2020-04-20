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
    
    var body: some View {
        HStack(alignment: .top, spacing: 32.0, content: {
            StatView(title: "Today", value: listener.stats.numberOfSessionsTitle)
            StatView(title: "Focused Time", value: listener.stats.totalTimeTitle)
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
