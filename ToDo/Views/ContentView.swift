//
//
// ContentView.swift
// ToDo
//
// Created by sturdytea on 28.08.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var modalType: ModalType? = nil
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(dataStore.tasks) { task in
                    Button(action: {
                        modalType = .update(task)
                    }, label: {
                        Text(task.name)
                            .font(.title3)
                            .strikethrough(task.isCompleted)
                            .foregroundColor(task.isCompleted ? .green : .black)
                    })
                }
                .onDelete(perform: dataStore.deleteTask.send)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("ToDo List")
                        .font(.largeTitle)
                        .foregroundColor(.pink)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        modalType = .new
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                }
            }
        }
        .sheet(item: $modalType) { modalType in
            modalType
        }
        .alert(item: $dataStore.appError) { appError in
            Alert(title: Text("Oops..."), message: Text(appError.error.localizedDescription))
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataStore())
}
