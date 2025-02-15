//
//  GameResult.swift
//  MovieQuiz
//
//  Created by Aleksey on 11.02.2025.
//
import Foundation

struct GameResult {
    let correctAnswersCount: Int
    let totalAnswersCount: Int
    let date: Date

    func isBetterThan(_ another: GameResult) -> Bool {
        correctAnswersCount > another.correctAnswersCount
    }
}
