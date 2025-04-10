//
//  SearchBarView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/9/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var query: String
    
    var body: some View {
        TextField("Search recipes", text: $query)
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal)
    }
}
