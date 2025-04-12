//
//  CuisineFilterView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/9/25.
//

import SwiftUI

struct CuisineFilterView: View {
    let allCuisines: [String]
    @Binding var selectedCuisines: Set<String>
    var onSave: () -> Void
    let purple: Color = Color(red: 48/255 ,green: 13/255,blue: 56/255)

    var body: some View {
        VStack {
            HStack {
                // Clear Filters Button
                Button(action: {
                    selectedCuisines.removeAll()
                }) {
                    Text("Clear")
                        .bold()
                        .foregroundColor(purple)
                }
                Spacer()
                // X button
                Button(action: {
                    onSave()
                }
                ) {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(purple)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
            
            // Navigation Title
            Text("Select Cuisines")
                .font(.title2)
                .bold()

            // Cuisine checkboxes
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(allCuisines, id: \.self) { cuisine in
                        HStack {
                            Image(systemName: selectedCuisines.contains(cuisine) ? "checkmark.square" : "square")
                            Text(cuisine)
                        }
                        .onTapGesture {
                            if selectedCuisines.contains(cuisine) {
                                selectedCuisines.remove(cuisine)
                            } else {
                                selectedCuisines.insert(cuisine)
                            }
                        }
                    }
                }
                .padding(.bottom)
            }

            // Save Button
            Button(action: {
                onSave()
            }) {
                Text("Save")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.frame(width: 300)
        }
        .padding()
        .frame(width: 375)
    }
}

#Preview {
    CuisineFilterView(
        allCuisines: ["Italian", "Mexican", "Indian", "Japanese"],
        selectedCuisines: .constant(Set(["Italian"])),
        onSave: {}
    )
}
