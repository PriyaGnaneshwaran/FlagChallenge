//
//  ScheduleView.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 24/07/25.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel = ScheduleViewModel()
    @State private var hour = 0
    @State private var minute = 0
    @State private var second = 0
    @State private var navigateToCountdown = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Color.orange
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .edgesIgnoringSafeArea(.top)
                
                VStack(spacing: 16) {
                    VStack {
                        HStack {
                            Text(Constant.timeTen)
                                .padding(8)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.black)
                                        .shadow(radius: 4)
                                )
                            Spacer()
                            
                            Text(Constant.flagsChallenge)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.orange)
                                .shadow(color: .black, radius: 2, x: 1, y: 0.5)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        Text(Constant.schecleYourChallange)
                            .font(.title2)
                            .fontWeight(.black)
                        
                        TimePickerView(hour: $hour, minute: $minute, second: $second)
                            .padding(.horizontal)
                        
                        Button(action: {
                            let now = Date()
                            let duration = TimeInterval(hour * 3600 + minute * 60 + second)
                            let scheduled = now.addingTimeInterval(duration)
                            viewModel.saveSelectedDate(scheduled)
                            // Schedule navigation after the duration
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                navigateToCountdown = true
                            }
                        }) {
                            Text(Constant.save)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 140)
                                .background(Color.orange)
                                .background(AngularGradient(colors: [.red,.gray,.green], center: .bottom))
                            
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: CountDownView(), isActive: $navigateToCountdown) {
                            EmptyView()
                        }
                        
                        Spacer()
                    }
                    .frame(height: 300)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            }
        }
    }
}

#Preview {
    ScheduleView()
}
