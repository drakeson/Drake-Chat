//
//  RegisterViewModel.swift
//  FireChat
//
//  Created by Dr.Drake 007 on 08/04/2021.
//

import Foundation

struct RegisterViewModel: AuthenticationProtocol {
    var username: String?
    var email: String?
    var password:String?
    
    var formIsValid: Bool {
        return username?.isEmpty == false
            && email?.isEmpty == false
            && password?.isEmpty == false
    }
}
