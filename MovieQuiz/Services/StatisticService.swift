//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Aleksey on 11.02.2025.
//

import Foundation

final class StatisticService {
    private let storage: UserDefaults = .standard

    private enum Keys: String {
        case totalCorrectAnswersCount
        case bestGameCorrectAnswersCount
        case bestGameTotalAnswersCount
        case bestGameDate
        case totalGamesCount
        case totalAccuracy
    }
}

extension StatisticService: StatisticServiceProtocol {
    var totalGamesCount: Int {
        get { storage.integer(forKey: Keys.totalGamesCount.rawValue) }
        set { storage.set(newValue, forKey: Keys.totalGamesCount.rawValue) }
    }

    var bestGame: GameResult {
        get {
            GameResult(
                correctAnswersCount: storage.integer(forKey: Keys.bestGameCorrectAnswersCount.rawValue),
                totalAnswersCount: storage.integer(forKey: Keys.bestGameTotalAnswersCount.rawValue),
                date: storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
            )
        }

        set(newValue) {
            storage.set(newValue.correctAnswersCount, forKey: Keys.bestGameCorrectAnswersCount.rawValue)
            storage.set(newValue.totalAnswersCount, forKey: Keys.bestGameTotalAnswersCount.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }

    var totalAccuracy: Double {
        get { storage.double(forKey: Keys.totalAccuracy.rawValue) }
        set { storage.set(newValue, forKey: Keys.totalAccuracy.rawValue) }
    }

    func store(correct count: Int, total amount: Int) {
        totalGamesCount += 1
        let currentGameResult = GameResult(correctAnswersCount: count, totalAnswersCount: amount, date: Date())
        if currentGameResult.isBetterThan(bestGame) {
            bestGame = currentGameResult
        }
        let totalCorrectAnswersCount = storage.integer(forKey: Keys.totalCorrectAnswersCount.rawValue) + count
        storage.set(totalCorrectAnswersCount, forKey: Keys.totalCorrectAnswersCount.rawValue)
        totalAccuracy = Double(totalCorrectAnswersCount) / Double(totalGamesCount * 10) * 100
    }
}
