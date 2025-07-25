//
//  QuestionViewModel.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 25/07/25.
//

import Foundation
import SwiftUI
import CoreData

class FlagsChallengeViewModel: ObservableObject {
    
    @Published var currentQuestionIndex = 0
    @Published var selectedOption: Int?
    @Published var isCorrect: Bool?
    @Published var score = 0
    @Published var timerValue = 30
    @Published var gameState: GameState = .playing
    @Published var remainingTime: Int = 30
    @Published var shouldNavigateToSchedule = false
    
    private var timer: Timer?
    private let totalQuestions = 30
    private let questions: [QuestionsModel]
    private let context: NSManagedObjectContext
    
    enum GameState {
        case playing
        case showingResult
        case finished
    }
    
    init(context: NSManagedObjectContext) {
        self.questions = FlagQuestionLoader.loadData()
        self.context = context
        loadProgress()
        startTimer()
    }
    
    private func loadProgress() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameProgress")
        do {
            let results = try context.fetch(request) as? [GameProgress]
            if let progress = results?.first {
                currentQuestionIndex = Int(progress.currentQuestionIndex)
                score = Int(progress.score)
                remainingTime = Int(progress.remainingTime)
                timerValue = remainingTime
            }
        } catch {
            print("Error loading progress: \(error)")
        }
    }
    
    private func saveProgress() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameProgress")
        do {
            let results = try context.fetch(request) as? [GameProgress]
            let progress = results?.first ?? GameProgress(context: context)
            progress.currentQuestionIndex = Int16(currentQuestionIndex)
            progress.score = Int16(score)
            progress.remainingTime = Int16(remainingTime)
            try context.save()
        } catch {
            print("Error saving progress: \(error)")
        }
    }
    
    
    func startTimer() {
        timer?.invalidate()
        timerValue = 30
        gameState = .playing
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timerValue > 0 {
                self.timerValue -= 1
            }
            
            if self.timerValue == 0 {
                self.timer?.invalidate()
                
                if self.selectedOption == nil {
                    self.isCorrect = false
                }
                
                self.gameState = .showingResult
                self.saveProgress()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.moveToNextQuestion()
                }
            }
        }
    }
    
    func selectOption(_ id: Int) {
        guard gameState == .playing else { return }
        
        selectedOption = id
        isCorrect = (id == questions[currentQuestionIndex].answer_id)
        
        if isCorrect == true {
            score += 1
        }
        
        gameState = .showingResult
        saveProgress()
    }
    
    func moveToNextQuestion() {
        selectedOption = nil
        isCorrect = nil
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            startTimer()
        } else {
            gameState = .finished
        }
    }
    
    func getCurrentQuestion() -> QuestionsModel? {
        guard currentQuestionIndex < questions.count, currentQuestionIndex < totalQuestions else { return nil }
        return questions[currentQuestionIndex]
    }
    
    func getFlagImageName() -> String {
        guard let question = getCurrentQuestion() else { return "" }
        return question.country_code
    }
    
    func resetGame() {
        currentQuestionIndex = 0
        score = 0
        timerValue = 30
        remainingTime = 30
        selectedOption = nil
        isCorrect = nil
        gameState = .playing
        shouldNavigateToSchedule = true 
        saveProgress()
    }
    
    deinit {
        timer?.invalidate()
    }
}
