//
//  LoginScreenView.swift
//  WestministerGardens
//
//  Created by Maggie Otto on 21/01/2025.
//

import SwiftUI

struct LoginScreenView: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    @EnvironmentObject var adminRights: AdminRights
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                TextField(
"Login.UsernameField.Title".localized,
                    text: $viewModel.username
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
                
                SecureField(
                    "Login.PasswordField.Title".localized,
                    text: $viewModel.password
                )
                .padding(.top, 20)
                
                Divider()
            }
            
            Spacer()
            
            Button(
                action: viewModel.login,
//                action: {
//                    self.adminRights.isAdmin.toggle()
//                },
                label: {
                    Text("Login.LoginButton.Title".localized)
                                            .font(.system(size: 24, weight: .bold, design: .default))
                                            .frame(maxWidth: .infinity, maxHeight: 60)
                                            .foregroundColor(Color.white)
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                    }
                                )
                            }
                            .padding(30)
                        }
                    }

                    struct LoginScreen_Previews: PreviewProvider {
                        static var previews: some View {
                            LoginScreenView()
                        }
                    }
