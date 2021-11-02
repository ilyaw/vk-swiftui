//
//  VKLoginWebView.swift
//  VKClient
//
//  Created by Ilya on 20.10.2021.
//

import SwiftUI
import WebKit
import SwiftKeychainWrapper

struct VKLoginWebView: UIViewRepresentable {
    
    fileprivate let navigationDelegate = WebViewNavigationDelegate()
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = navigationDelegate
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let request = buildAuthRequest() {
            uiView.load(request)
        }
    }
    
    private func buildAuthRequest() -> URLRequest? {
        let friendsMask = 1 << 1
        let photosMask = 1 << 2
        let wallMask = 1 << 13
        let groupsMask = 1 << 18
        
        let scope = friendsMask + photosMask + wallMask + groupsMask
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7798550"),
            URLQueryItem(name: "scope", value: "\(scope)"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        
        return components.url.map { URLRequest(url: $0) }
    }
}

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
                  decisionHandler(.allow)
                  return
              }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let userId = Int(userIdString) else {
                  decisionHandler(.allow)
                  return
              }
        
        UserDefaults.standard.set(token, forKey: "vkToken")
        UserDefaults.standard.set(userId, forKey: "userId")
        
        let user = KeychainUser(id: userId,
                                token: token,
                                date: Date().timeIntervalSince1970)
        
        let encodedUser = encode(object: user)
        KeychainWrapper.standard["user"] = encodedUser
        
        NotificationCenter.default.post(name: NSNotification.VKTokenSaved, object: self)
        
        decisionHandler(.cancel)
    }
}
