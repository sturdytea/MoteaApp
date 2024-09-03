//
//
// TaskFormViewModel.swift
// ToDo
//
// Created by sturdytea on 28.08.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

class TaskFormViewModel: ObservableObject {
    var id: String?
    @Published var name = ""
    @Published var isCompleted = false
    
    var updating: Bool {
        id != nil
    }
    
    var isDisabled: Bool {
        name.isEmpty
    }
    
    init() {
        
    }
    
    init(_ currentTask: Task) {
        self.id = currentTask.id
        self.name = currentTask.name
        self.isCompleted = currentTask.isCompleted
    }
}
