//
//  QuestionView.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 25/07/25.
//

import SwiftUI

struct QuestionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: QuestionViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: QuestionViewModel(context: PersistenceController.shared.container.viewContext))
    }
    
    var body: some View {
        VStack {
            Color.orange
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 16) {
                VStack {
                    HStack {
                        if viewModel.gameState != .finished {
                            Text("00:\(String(format: "%02d", viewModel.timerValue))")
                                .padding(8)
                                .background(Color.black)
                                .foregroundStyle(.white)
                                .font(.system(size: 15))
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                        
                        Spacer()
                        
                        Text(Constant.flagsChallenge)
                            .foregroundStyle(.orange)
                            .shadow(color: .black, radius: 2, x: 1, y: 0.5)
                            .font(.system(size: 20, weight: .bold))
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    if viewModel.gameState != .finished {
                        HStack {
                            Text(" \(viewModel.currentQuestionIndex + 1) ")
                                .background(Color.orange)
                                .foregroundStyle(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Spacer()
                            
                            Text(Constant.question)
                                .foregroundStyle(.black)
                                .font(.system(size: 12))
                            
                            Spacer()
                        }
                    }
                    
                    if viewModel.gameState != .finished {
                        if let question = viewModel.getCurrentQuestion() {
                            HStack {
                                Image(viewModel.getFlagImageName())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                                    .padding(.vertical)
                                
                                Spacer()
                                
                                VStack(spacing: 12) {
                                    HStack(spacing: 12) {
                                        OptionButton(
                                            title: question.countries[0].country_name,
                                            id: question.countries[0].id,
                                            isSelected: viewModel.selectedOption == question.countries[0].id,
                                            isCorrect: (viewModel.shouldShowCorrectAnswer && question.countries[0].id == question.answer_id) ||
                                                                   ((viewModel.isCorrect ?? false) && question.countries[0].id == question.answer_id),
                                            showResult: viewModel.gameState == .showingResult,
                                            action: { viewModel.selectOption(question.countries[0].id)
}
                                        )
                                        OptionButton(
                                            title: question.countries[1].country_name,
                                            id: question.countries[1].id,
                                            isSelected: viewModel.selectedOption == question.countries[1].id,
                                            isCorrect: (viewModel.shouldShowCorrectAnswer && question.countries[1].id == question.answer_id) ||
                                                                   ((viewModel.isCorrect ?? false) && question.countries[1].id == question.answer_id),
                                            showResult: viewModel.gameState == .showingResult,
                                            action: { viewModel.selectOption(question.countries[1].id) }
                                        )
                                    }
                                    HStack(spacing: 12) {
                                        OptionButton(
                                            title: question.countries[2].country_name,
                                            id: question.countries[2].id,
                                            isSelected: viewModel.selectedOption == question.countries[2].id,
                                            isCorrect: (viewModel.shouldShowCorrectAnswer && question.countries[2].id == question.answer_id) ||
                                                                  ((viewModel.isCorrect ?? false) && question.countries[2].id == question.answer_id),
                                            showResult: viewModel.gameState == .showingResult,
                                            action: { viewModel.selectOption(question.countries[2].id) }
                                        )
                                        OptionButton(
                                            title: question.countries[3].country_name,
                                            id: question.countries[3].id,
                                            isSelected: viewModel.selectedOption == question.countries[3].id,
                                            isCorrect: (viewModel.shouldShowCorrectAnswer && question.countries[3].id == question.answer_id) ||
                                                       ((viewModel.isCorrect ?? false) && question.countries[3].id == question.answer_id),

                                            showResult: viewModel.gameState == .showingResult,
                                            action: { viewModel.selectOption(question.countries[3].id) }
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    } else {
                        VStack(spacing: 10) {
                            Text(Constant.gameOver)
                                .font(.system(size: 30, weight: .bold))
                                .foregroundStyle(.orange)
                            Text("SCORE: \(viewModel.score)/15")
                                .font(.system(size: 20))
                                .foregroundStyle(.black)
                            
                            
                            Button(action: {
                                viewModel.resetGame()
                            }) {
                                Text(Constant.restart)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .font(.system(size: 18, weight: .medium))
                                    .padding(.horizontal)
                            }
                            NavigationLink(destination: ScheduleView().navigationBarBackButtonHidden(true), isActive: $viewModel.shouldNavigateToSchedule) {
                                EmptyView()
                            }
                        }
                    }
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
        }
        .onAppear {
//            viewModel.loadProgress()
        }
        .onDisappear {
            viewModel.resetGame()
        }
    }
}

#Preview {
    QuestionView()
}
