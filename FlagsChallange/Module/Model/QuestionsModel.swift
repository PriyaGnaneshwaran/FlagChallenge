//
//  Questions.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 24/07/25.
//

import Foundation

struct QuestionResponse: Codable {
    let questions: [QuestionsModel]
}

struct QuestionsModel: Codable {
    let answer_id: Int
    let countries: [Country]
    let country_code: String
}

struct Country: Codable, Identifiable {
    let country_name: String
    let id: Int
}
