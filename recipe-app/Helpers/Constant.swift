//
//  Constant.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation

struct Constant {
    static let baseURL: URL = {
        let baseURLPublishing: String = "https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/"
        return URL(string: baseURLPublishing)!
    }()
    
    struct Messages {
        static let noNetworkConnection = "No network connection. Please connect to the internet"
    }
}
