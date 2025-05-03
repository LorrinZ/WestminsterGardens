

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
