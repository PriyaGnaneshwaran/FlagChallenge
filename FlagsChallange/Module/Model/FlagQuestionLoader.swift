//
//  FlagQuestionLoader.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 24/07/25.
//

import Foundation

struct FlagQuestionLoader {
    static func loadData() -> [QuestionsModel] {
        guard let url = Bundle.main.url(forResource: "Questions", withExtension: "json") else {
            print("Error: Questions.json not found in bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONDecoder().decode(QuestionResponse.self, from: data)
            if json.questions.isEmpty {
                print("Warning: Questions.json is empty")
            }
            return json.questions
        } catch {
            print("Error decoding Questions.json: \(error.localizedDescription)")
            return []
        }
    }
}
