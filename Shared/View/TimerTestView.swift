//
//  TimerTestView.swift
//  Messnger_new
//
//  Created by Алексей Дробный on 14.05.2022.
//

import SwiftUI

struct TimerTestView: View {
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

        var body: some View {
            Text("Hello, World!")
                .onReceive(timer) { time in
                        print("The time is now \(time)")
                }
        }
}

struct TimerTestView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTestView()
    }
}
