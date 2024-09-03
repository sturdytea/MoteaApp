//
//
// TaskFormView.swift
// ToDo
//
// Created by sturdytea on 28.08.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import SwiftUI

struct TaskFormView: View {
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var viewModel: TaskFormViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading) {
                    TextField("Task Name", text: $viewModel.name)
                    Toggle("Completed", isOn: $viewModel.isCompleted)
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)
        }
    }
}

extension TaskFormView {
    func addTask() {
        let newTask = Task(name: viewModel.name)
        dataStore.addTask.send(newTask)
        presentationMode.wrappedValue.dismiss()
    }
    
    func updateTask() {
        let newTask = Task(id: viewModel.id!, name: viewModel.name, isCompleted: viewModel.isCompleted)
        dataStore.updateTask.send(newTask)
        presentationMode.wrappedValue.dismiss()
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }

    var updateSaveButton: some View {
        Button(viewModel.updating ? "Update" : "Save") {
            viewModel.updating ? updateTask() : addTask()
        }
        .disabled(viewModel.isDisabled)
    }
}

#Preview {
    TaskFormView(viewModel: TaskFormViewModel())
        .environmentObject(DataStore())
}
