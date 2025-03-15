protocol QuestionFactoryDelegate: AnyObject {
    func didReciveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
