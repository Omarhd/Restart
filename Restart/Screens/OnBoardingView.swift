//
//  OnBoardingView.swift
//  Restart
//
//  Created by Omar Abdulrahman on 27/11/2023.
//

import SwiftUI

struct OnBoardingView: View {
    
    //MARK: - Properties
    @AppStorage("onboarding") private var isOnBoardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var titleText: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Spacer()
                
                //MARK: - HEADER
                VStack(spacing: 0) {
                    Text(titleText)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(titleText)
                    
                    Text("It's not how much we give but how much love we put into giving.")
                        .font(.title3)
                        .fontWeight (.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment (.center)
                        .padding(.horizontal, 10)
                    
                } //: HEADER VSTACK
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: - CENTER
                ZStack {
                    
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur (radius: abs(imageOffset.width / 5))
                        .animation(.easeOut (duration: 0.5), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(x: isAnimating ? 0 : +80)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear (duration: 0.25)) {
                                            indicatorOpacity = 0
                                            titleText = "Give."
                                        }
                                    }
                                }
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear (duration: 0.25)) {
                                        indicatorOpacity = 1
                                        titleText = "Share."
                                    }
                                })
                        ) //: END GESTURE
                        .animation(.easeInOut(duration: 1), value: isAnimating)
                } //: CENTER ZSTACK
                .overlay (
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                ,alignment: .bottom
                )
                
                Spacer()
                
                //: MARK: - FOOTER
                ZStack {
                    // 1: Background Static
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2: Call to Action Static
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    // 3: Capsule Dynamic Width
                    HStack {
                        Capsule()
                            .fill(Color.RedColor)
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    } //: END HSTACK
                    
                    // 4: Circle Dragable
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.RedColor)
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        } //: END ZSTACK
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnBoardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        ) //: END GESTURE
                        .animation(.easeInOut(duration: 1), value: isAnimating)
                        
                        Spacer()
                        
                    } //: END HSTACK
                } //: FOOTER HSTACK
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VSTACK
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    } //: BODY
}

#Preview {
    OnBoardingView()
}
