//
//
// TaskError.swift
// ToDo
//
// Created by sturdytea on 02.09.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

enum TaskError: Error,LocalizedError {
    case saveError, readError, decodingError, encodingError
    
    var errorDescription: String? {
        switch self {
        case .saveError:
            return NSLocalizedString("Could not save Tasks, please reinstall the ToDo app.", comment: "")
        case .readError:
            return NSLocalizedString("Could not read Tasks, please reinstall the ToDo app.", comment: "")
        case .decodingError:
            return NSLocalizedString("Loading Tasks problem occured. Please create a new Task to start over.", comment: "")
        case .encodingError:
            return NSLocalizedString("Could not save Tasks, please reinstall the ToDo app.", comment: "")
        }
    }
}

struct ErrorType: Identifiable {
    let id = UUID()
    let error: TaskError
}
