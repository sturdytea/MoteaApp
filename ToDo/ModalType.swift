//
//
// ModalType.swift
// ToDo
//
// Created by sturdytea on 28.08.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import SwiftUI

enum ModalType: Identifiable, View {
    case new
    case update(Task)
    var id: String {
        switch self {
        case .new:
            return "new"
        case . update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new:
            return TaskFormView(viewModel: TaskFormViewModel())
        case .update(let task):
            return TaskFormView(viewModel: TaskFormViewModel(task))
        }
    }
}
