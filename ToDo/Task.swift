//
//
// Task.swift
// ToDo
//
// Created by sturdytea on 28.08.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct Task: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var isCompleted: Bool = false
    
    public static var sampleData: [Task] = [
            Task(name: "My New Note"),
            Task(name: "Completed", isCompleted: true)
    ]
}
