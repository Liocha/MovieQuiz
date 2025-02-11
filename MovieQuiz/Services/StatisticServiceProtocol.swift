//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Aleksey on 11.02.2025.
//
protocol StatisticServiceProtocol {
    var totalGamesCount: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }

    func store(correct count: Int, total amount: Int)
}
