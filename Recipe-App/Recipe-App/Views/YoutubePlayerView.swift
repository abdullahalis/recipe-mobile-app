//
//  YoutubePlayerView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/10/25.
//

import SwiftUI
import WebKit

struct YoutubePlayerView: UIViewRepresentable {
    
    let videoURL: String
    @Binding var isLoading: Bool
    
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.navigationDelegate = context.coordinator
        webView.configuration.allowsInlineMediaPlayback = true
        webView.scrollView.isScrollEnabled = false
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let videoID = extractID()
        guard let url = URL(string: "http://www.youtube.com/embed/\(videoID ?? "")") else { return }
        
        let request = URLRequest(url: url)
        
        // Make view not scrollable for better UX
        
        uiView.load(request)
        
    }
    
    func extractID() -> String? {
        guard let components = URLComponents(string: videoURL) else { return nil}
        
        // Extract ID from URL parameter "v"
        return components.queryItems?.first(where: { $0.name == "v" })?.value
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isLoading: $isLoading)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var isLoading: Bool

        init(isLoading: Binding<Bool>) {
            _isLoading = isLoading
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("finished vidoeload")
            isLoading = false
        }
    }
}

#Preview {
    YoutubePlayerView(videoURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg", isLoading: .constant(true))
}
