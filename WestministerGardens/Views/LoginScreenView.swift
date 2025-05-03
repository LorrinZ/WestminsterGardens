
import SwiftUI
struct LoginScreenView: View {
    @Binding var isLoggedIn: Bool
    @Binding var isAdmin: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false
    let normUsername = "norm"
    let normPassword = "password321"
    let adminUsername = "admin"
    let adminPassword = "password123"
    var body: some View {
        VStack {
            Spacer()
            Text("Login")
                .font(.title)
                .padding()
            
            Form {
                Section {
                    TextField("Username", text: $username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $password)
                }
            }
            .frame(height: 150)
            .cornerRadius(10)
            .padding()
            Button("Login") {
                if username == adminUsername && password == adminPassword {
                    isLoggedIn = true
                    isAdmin = true
                } else if username == normUsername && password == normPassword {
                    isLoggedIn = true
                    isAdmin = false
                } else {
                    showError = true
                    
                    
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            if showError {
                Text("Invalid credentials")
                    .foregroundColor(.red)
            }
            Spacer()
        }
    }
}
