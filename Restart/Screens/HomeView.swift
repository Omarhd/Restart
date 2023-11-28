//
//  HomeView.swift
//  Restart
//
//  Created by Omar Abdulrahman on 27/11/2023.
//

import SwiftUI

struct HomeView: View {
   
    //MARK: - Properties
    @AppStorage("onboarding") private var isOnBoardingViewActive: Bool = true
   
    @State private var isAnimating: Bool = false

    let hapticFeedback = UINotificationFeedbackGenerator()

    //MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            
            //MARK: - HEADER
            Spacer()
            
            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 25 : -25)
                    .animation(
                    Animation
                        .easeOut(duration: 4)
                        .repeatForever()
                        , value: isAnimating
                    )
            } //: END ZSTACK
            
            //MARK: - CENTER
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font (.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment (.center)
                .padding()
            
            //MARK: - FOOTER
            Spacer()
            
            Button {
                withAnimation {
                    isOnBoardingViewActive = true
                    playSound (sound: "success", type: "m4a")
                    hapticFeedback.notificationOccurred(.success)
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale (.large)
                
                Text ("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            } //: BUTTON
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } //: VSTACK
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                isAnimating = true
            })
        })
    }
}

#Preview {
    HomeView()
}
