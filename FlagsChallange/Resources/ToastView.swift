//
//  ToastView.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 25/07/25.
//

import SwiftUI

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(12)
            .padding(.bottom, 40)
    }
}
