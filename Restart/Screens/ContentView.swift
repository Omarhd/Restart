//
//  ContentView.swift
//  Restart
//
//  Created by Omar Abdulrahman on 27/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") private var isOnBoardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
            switch isOnBoardingViewActive {
            case true:
                OnBoardingView()
            case false:
                HomeView()
            } 
        }
    }
}

#Preview {
    ContentView()
}
