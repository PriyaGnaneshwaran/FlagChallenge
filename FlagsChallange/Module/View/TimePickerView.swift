//
//  TimePickerView.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 24/07/25.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    
    var body: some View {
        HStack(spacing: 12) {
            
            VStack(spacing: 5) {
                Text(Constant.hour)
                    .font(.headline)
                Picker("", selection: $hour) {
                    ForEach(0..<13) { Text("\($0)").tag($0) }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 80)
            }

            VStack(spacing: 5) {
                Text(Constant.minute)
                    .font(.headline)
                Picker("", selection: $minute) {
                    ForEach(0..<61) { Text("\($0)").tag($0) }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 80)
            }

            VStack(spacing: 5) {
                Text(Constant.second)
                    .font(.headline)
                Picker("", selection: $second) {
                    ForEach(0..<61) { Text("\($0)").tag($0) }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 80)
            }
        }
        .padding(.vertical, 4)
    }
}

