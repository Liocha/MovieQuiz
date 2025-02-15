//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Aleksey on 10.02.2025.
//
import UIKit

final class AlertPresenter: ShowAlertProtocol {
    weak var delegate: MovieQuizViewController?

    func showAlert(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert
        )

        let action = UIAlertAction(
            title: alertModel.buttonText,
            style: .default
        ) { _ in
            alertModel.completion()
        }

        alert.addAction(action)
        delegate?.present(alert, animated: true, completion: nil)
    }
}
