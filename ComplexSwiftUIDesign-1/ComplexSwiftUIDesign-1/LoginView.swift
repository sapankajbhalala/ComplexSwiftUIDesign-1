//
//  LoginView.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 01/04/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    @State var email: String = ""
    @State var password: String = ""
    @State var alertMsg = ""
    
    @State private var showForgotPassword = false
    @State private var showSignup = false
    @State var showAlert = false
    @State var showDetails = false
    
    @State var loginSelection: Int? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    var body: some View {
        
        VStack {
            
            VStack {
                Spacer(minLength: (CScreenSizeBounds.width * 15) / 414)
                
                RoundedImage()
                
                Spacer(minLength: (CScreenSizeBounds.width * 15) / 414)
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_email")
                            .padding(.leading, (CScreenSizeBounds.width * 20) / 414)
                        
                        TextField("Email", text: $email)
                            .frame(height: (CScreenSizeBounds.width * 40) / 414, alignment: .center)
                            .padding(.leading, (CScreenSizeBounds.width * 10) / 414)
                            .padding(.trailing, (CScreenSizeBounds.width * 10) / 414)
                            .font(.system(size: (CScreenSizeBounds.width * 15) / 414, weight: .regular, design: .default))
                            .imageScale(.small)
                            .keyboardType(.emailAddress)
                            .autocapitalization(UITextAutocapitalizationType.none)
                        
                    }
                    seperator()
                }
                
                Spacer(minLength: (CScreenSizeBounds.width * 15) / 414)
                
                VStack {
                    
                    HStack {
                        Image("ic_password")
                            .padding(.leading, (CScreenSizeBounds.width * 20) / 414)
                        
                        SecureField("Password", text: $password)
                            .frame(height: (CScreenSizeBounds.width * 40) / 414, alignment: .center)
                            .padding(.leading, (CScreenSizeBounds.width * 10) / 414)
                            .padding(.trailing, (CScreenSizeBounds.width * 10) / 414)
                            .font(.system(size: (CScreenSizeBounds.width * 15) / 414, weight: .regular, design: .default))
                            .imageScale(.small)
                    }
                    seperator()
                    
                }
                
                Spacer(minLength: (CScreenSizeBounds.width * 15) / 414)
                
            }
                
            .alert(isPresented: $showAlert, content: { self.alert })
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }
    
    
    fileprivate func isValidInputs() -> Bool {
        
        if self.email == "" {
            self.alertMsg = "Email can't be blank."
            self.showAlert.toggle()
            return false
        } else if !self.email.isValidEmail {
            self.alertMsg = "Email is not valid."
            self.showAlert.toggle()
            return false
        } else if self.password == "" {
            self.alertMsg = "Password can't be blank."
            self.showAlert.toggle()
            return false
        } else if !(self.password.isValidPassword) {
            self.alertMsg = "Please enter valid password"
            self.showAlert.toggle()
            return false
        }
        
        return true
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
