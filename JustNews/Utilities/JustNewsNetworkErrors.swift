//
//  JustNewsNetworkErrors.swift
//  JustNews
//
//  Created by G on 04/02/2024.
//

import Foundation

enum JNError: String, Error{
    case unableToComplete = "Unable to complete request"
    case invalidResponse = "Invalid Response from server"
    case invalidData = "The data recieved was invalid"
    case cantDecode = "Cant decode"
}
