//
//  LoginViewModel.swift
//  WestministerGardens
//
//  Created by Maggie Otto on 21/01/2025.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @EnvironmentObject var adminRights: AdminRights

    func login() {
        if username == "lorrin" {
            adminRights.isAdmin.toggle()
        }
//        LoginAction(
//            parameters: LoginRequest(
//                username: username,
//                password: password
//            )
//        ).call { _ in
//            // Login successful, navigate to the Home screen
//        }
    }

}
