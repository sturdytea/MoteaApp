//
//
// ToDoApp.swift
// ToDo
//
// Created by sturdytea on 28.08.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import SwiftUI

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
        }
    }
}
