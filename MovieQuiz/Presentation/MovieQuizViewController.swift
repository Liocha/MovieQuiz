import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    private var currentQuestion: QuizQuestion?
    private var alertPresenter: ShowAlertProtocol?
    private var presenter: MovieQuizPresenter!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let alertPresenter = AlertPresenter()
        alertPresenter.delegate = self
        self.alertPresenter = alertPresenter

        presenter = MovieQuizPresenter(viewController: self)
    }

    // MARK: - QuestionFactoryDelegate

    func didReciveNextQuestion(question: QuizQuestion?) {
        presenter.didReceiveNextQuestion(question: question)
    }

    // MARK: - Actions

    @IBAction private func noButtonClicked(_: UIButton) {
        presenter.noButtonClicked()
    }

    @IBAction private func yesButtonClicked(_: UIButton) {
        presenter.yesButtonClicked()
    }

    // MARK: - Private functions

    func show(quiz step: QuizStepViewModel) {
        changeStateButton(isEnabled: true)
        imageView.layer.borderWidth = 0
        
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }

    func show(quiz result: QuizResultsViewModel) {
        let alertModel = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: "Сыграть еще раз",
            completion: { [weak self] in
                guard let self = self else { return }
                self.presenter.restartGame()
            }
        )
        alertPresenter?.showAlert(alertModel: alertModel)
    }

    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        changeStateButton(isEnabled: false)
    }

    private func changeStateButton(isEnabled: Bool) {
        noButton.isEnabled = isEnabled
        yesButton.isEnabled = isEnabled
    }
         
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
    }

    func showNetworkError(message: String) {
        hideLoadingIndicator()

        let alertModel = AlertModel(
            title: "Что-то пошло не так(",
            message: message,
            buttonText: "Попробовать еще раз"
        ) { [weak self] in
            guard let self = self else { return }
            self.presenter.restartGame()
        }

        alertPresenter?.showAlert(alertModel: alertModel)
    }

    func didFailToLoadData(with _: Error) {
        let universalTextError = "Невозможно загрузить данные "
        showNetworkError(message: universalTextError)
    }
}
