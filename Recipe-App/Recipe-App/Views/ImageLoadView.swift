//
//  ImageLoadView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/7/25.
//

import SwiftUI

struct ImageLoadView: View {
    @StateObject var imageLoader: ImageLoad
    
    init(endpoint: String) {
        self._imageLoader = StateObject(wrappedValue: ImageLoad(endpoint: endpoint))
    }
    
    var body: some View {
        Group {
            
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .scaledToFit()
            } else if imageLoader.error != nil {
                EmptyView()
//                Rectangle().fill(.gray)
            } else {
                ProgressView()
            }
        }
        .task {
            await imageLoader.loadImage()

        }
    }
}

#Preview {
    ImageLoadView(endpoint: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpgx")
}
