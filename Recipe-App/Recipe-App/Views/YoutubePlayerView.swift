//
//  YoutubePlayerView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/10/25.
//

import SwiftUI
import WebKit

struct YoutubePlayerView: UIViewRepresentable { // To use web view
    
    let videoURL: String
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator // Use custom coordinator to keep track of loading
        webView.configuration.allowsInlineMediaPlayback = true
        webView.scrollView.isScrollEnabled = false
        
        return webView
    }
    
    // Called when videoURL changes
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let videoID = extractID()
        guard let url = URL(string: "http://www.youtube.com/embed/\(videoID ?? "")") else { return }
        
        // Create request to get webpage from url
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    // Get ID from URL
    func extractID() -> String? {
        guard let components = URLComponents(string: videoURL) else { return nil}
        
        // Extract ID from URL parameter "v"
        return components.queryItems?.first(where: { $0.name == "v" })?.value
    }
    
    // Called automatically by makeUIView
    func makeCoordinator() -> Coordinator {
        Coordinator(isLoading: $isLoading)
    }
    
    // Coordinator to track loading state
    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var isLoading: Bool

        init(isLoading: Binding<Bool>) {
            _isLoading = isLoading
        }
        
        // set isLoading to false when video finished loading
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("finished vidoeload")
            isLoading = false
        }
    }
}

#Preview {
    YoutubePlayerView(videoURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg", isLoading: .constant(true))
}
