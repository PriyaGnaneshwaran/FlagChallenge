import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "FlagsChallengeModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading persistent stores: \(error)")
            }
        }
    }

    func saveAnswer(questionIndex: Int, selectedAnswerID: Int) {
        let context = container.viewContext
        let answer = Answer(context: context)
        answer.id = UUID()
        answer.questionIndex = Int16(questionIndex)
        answer.selectedAnswerID = Int16(selectedAnswerID)
        saveContext()
    }

    func fetchAnswers() -> [Answer] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<Answer> = Answer.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch answers: \(error)")
            return []
        }
    }

    private func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save Core Data context: \(error)")
            }
        }
    }
}