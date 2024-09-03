//
//
// TaskViewModel.swift
// ToDo
//
// Created by sturdytea on 28.08.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation
import Combine

class DataStore: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var appError: ErrorType? = nil
    var addTask = PassthroughSubject<Task, Never>()
    var updateTask = PassthroughSubject<Task, Never>()
    var deleteTask = PassthroughSubject<IndexSet, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        print(FileManager.docDirURL.path)
        addSubscriptions()
        if FileManager().docExist(named: fileName) {
            loadTasks()
        }
    }
    
    func addSubscriptions() {
        addTask
            .sink { [unowned self] task in
                tasks.append(task)
                saveTasks()
            }
            .store(in: &subscriptions)
        
        updateTask
            .sink { [unowned self] task in
                guard let index = tasks.firstIndex(where: {$0.id == task.id}) else {
                    return
                }
                tasks[index] = task
                saveTasks()
            }
            .store(in: &subscriptions)
        
        deleteTask
            .sink { [unowned self] indexSet in
                tasks.remove(atOffsets: indexSet)
                saveTasks()
            }
            .store(in: &subscriptions)
    }
    
    func loadTasks() {
        FileManager().readDocument(docName: fileName) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    tasks = try decoder.decode([Task].self, from: data)
                } catch {
                    appError = ErrorType(error: .decodingError)
                }
            case .failure(let error):
                appError = ErrorType(error: error)
            }
        }
    }
    
    func saveTasks() {
        print("Saving tasks to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(tasks)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { error in
                if let error = error {
                    appError = ErrorType(error: error)
                }
            }
        } catch {
            appError = ErrorType(error: .encodingError)
        }
    }
}
