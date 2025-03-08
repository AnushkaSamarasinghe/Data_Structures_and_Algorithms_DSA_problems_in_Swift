//
//  CustomTextField.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

import SwiftUI

struct CustomTextField: View {
    let placeHolderText: String
    let color: Color
    @Binding var value: String
    
    var body: some View {
        TextField(placeHolderText, text: $value)
            .padding(10)
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .foregroundColor(Color.black.opacity(0.8))
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color:color.opacity(0.2),radius: 10,x:0, y:4)
    }
}

#Preview {
    CustomTextField(placeHolderText: "placeholder", color: .green, value: .constant(""))
}
