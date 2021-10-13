//
//  UIApplication + Extension.swift
//  VKClient
//
//  Created by Ilya on 13.10.2021.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
