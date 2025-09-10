//
//  CountDownView.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 24/07/25.
//

import SwiftUI

struct CountDownView: View {
    @State private var timeRemaining = 20
    @State private var isActive = true
    @State private var showChallenge = false
   
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Color.orange
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(edges: .top)

                VStack {
                    VStack(spacing: 16) {
                        HStack {
                            Text(Constant.timeTen)
                                .padding(8)
                                .background(Color.black)
                                .foregroundStyle(.white)
                                .font(.system(size: 15))
                                .clipShape(RoundedRectangle(cornerRadius: 6))

                            Spacer()

                            Text(Constant.flagsChallenge)
                                .foregroundStyle(.orange)
                                .shadow(color: .black, radius: 2, x: 1, y: 0.5)
                                .font(.system(size: 20, weight: .bold))

                            Spacer()
                        }
                        
                        Divider()

                        VStack(spacing: 8) {
                            Text(Constant.challengs)
                                .font(.system(size: 20,weight: .bold))
                                .foregroundStyle(.black)

                            Text(Constant.willStartIn)
                                .font(.headline)
                                .foregroundStyle(.black)
                        }

                        Text(String(format: "00:%02d", timeRemaining))
                            .font(.title2)
                            .foregroundStyle(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)

                NavigationLink(destination: QuestionView(), isActive: $showChallenge) {
                    EmptyView()
                }
            }
            .onReceive(timer) { _ in
                guard isActive else { return }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    isActive = false
                    showChallenge = true
                }
            }
        }
    }
}


#Preview {
    CountDownView()
}
