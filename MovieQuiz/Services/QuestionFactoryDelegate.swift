//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Aleksey on 10.02.2025.
//

protocol QuestionFactoryDelegate: AnyObject {
    func didReciveNextQuestion(question: QuizQuestion?)
}
