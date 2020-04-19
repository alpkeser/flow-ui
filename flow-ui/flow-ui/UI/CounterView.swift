//
//  CounterView.swift
//  flow-ui
//
//  Created by Alp Keser on 17.04.2020.
//  Copyright © 2020 Alp Keser. All rights reserved.
//


import SwiftUI
import Combine
import UIKit

struct CounterView: View {
    @ObservedObject var counter: Counter
    var counterTextSize: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 216.0 : 96.0
    }
    var counterText: some View {
        Text("\(counter.timeLeft)").font(Font.system(size: counterTextSize, weight: .semibold, design: .default).monospacedDigit()).foregroundColor(Color("primaryText")).minimumScaleFactor(0.1)
    }
    
    var playButton: some View {
        if counter.state == .running {
            return Button(action: {
                self.counter.pause()
            }) {
                Image("stopButton").renderingMode(.original)
            }
        } else {
            return Button(action: {
                self.counter.start()
            }) {
                Image("startButton").renderingMode(.original)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
        ZStack{
            Circle().stroke(Color("focusOrange"), lineWidth: 11).padding()
            Circle().trim(from: 0, to: 1.0 - self.counter.counterRingTrimValue).stroke(Color.white, lineWidth: 14).opacity(0.6).rotationEffect(.degrees(-90)).padding().animation(.linear(duration: self.counter.state == .running ? self.counter.secondsLeft : 0))
            self.counterText
                VStack {
                    Spacer()
                    self.playButton.padding(.bottom, ((geometry.size.height / 4) - 26) )
                }

            }
        }.aspectRatio(contentMode: .fit)
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(counter: Counter(sessionTime: 60)).padding(.horizontal)
    }
}


