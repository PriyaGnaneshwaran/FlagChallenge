//
//  OptionButton.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 25/07/25.
//

import SwiftUI

struct OptionButton: View {
    let title: String
    let id: Int
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(title)
                    .foregroundStyle(isSelected ? .white : .black)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .lineLimit(2) 
                    .background(
                        showResult && isCorrect ? Color.green :
                        showResult && isSelected ? Color.red :
                        isSelected ? Color.blue : Color.gray.opacity(0.3)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                if showResult {
                    if isSelected && !isCorrect {
                        Text(Constant.wrong)
                            .foregroundStyle(.red)
                            .font(.system(size: 12))
                            .padding(.top, 2)
                    } else if isCorrect {
                        Text(Constant.correct)
                            .foregroundStyle(.green)
                            .font(.system(size: 12))
                            .padding(.top, 2)
                    }
                }
            }
            .frame( height: 70)
        }
        .disabled(showResult)
    }
}

