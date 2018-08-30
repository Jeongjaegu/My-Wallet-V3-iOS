//
//  UserAgent.swift
//  Blockchain
//
//  Created by Maurice A. on 4/16/18.
//  Copyright © 2018 Blockchain Luxembourg S.A. All rights reserved.
//

import Foundation

@objc
extension NetworkManager {
    static var userAgent: String? {
        let webView = UIWebView(frame: .zero)
        guard let userAgent = webView.stringByEvaluatingJavaScript(from: "navigator.userAgent"),
            let version = Bundle.applicationVersion else {
                return nil
        }
        return userAgent + " Blockchain/" + version
    }
}
