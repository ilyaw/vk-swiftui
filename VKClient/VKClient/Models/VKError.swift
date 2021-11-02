//
//  VKError.swift
//  VKClient
//
//  Created by Ilya on 30.10.2021.
//

import Foundation

enum VKError: Error {
    case needValidation(message: String)
    case cannotDeserialize(message: String)
    case dataIsEmpty(message: String)
    case limitIsexceeded(message: String)
}

extension VKError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cannotDeserialize(let message):
            return NSLocalizedString(message, comment: "")
        case .needValidation(message: let message):
            return NSLocalizedString(message, comment: "")
        case .dataIsEmpty(message: let message):
            return NSLocalizedString(message, comment: "")
        case .limitIsexceeded(message: let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
