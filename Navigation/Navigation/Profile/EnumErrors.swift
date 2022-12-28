//
//  EnumErrors.swift
//  Navigation
//
//  Created by Sokolov on 22.12.2022.
//

import UIKit

enum NetworkError: Error {
    case NetwrokError200
    case NetworkError404
}

enum DataBaseError: Error {
    case incorrectSendDate
    case incorrectData
    case incorrectReceivedData
}
