//
//  FlagQuestionLoader.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 24/07/25.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.green.opacity(0.3), .mint.opacity(0.3), .cyan.opacity(0.3)],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(Constant.flags)
                            .font(.system(size: 70, weight: .bold))
                            .foregroundColor(.primary)

                        Text(Constant.challengs)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.primary)

                        Text(Constant.description)
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(.green)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 30)

                    
                    VStack(spacing: 20) {
                        Image("ic_worldMap")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 280, height: 280)
                            .padding(.top, 50)
                    }

                        NavigationLink {
                            ScheduleView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text(Constant.letsBegin)
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .frame(width: 200)
                                .background(
                                    LinearGradient(colors: [.green, .teal], startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                        .padding(.bottom,50)
                        Spacer()
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
