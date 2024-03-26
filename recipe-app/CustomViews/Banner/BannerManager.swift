//
//  BannerManager.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation
import NotificationBannerSwift

final class BannerManager {
    static private func createBanner(_ subtitle: String,
                             _ style: BannerStyle) {
        let banner = GrowingNotificationBanner(title: "", subtitle: subtitle, style: style)
        if style == .success {
            banner.backgroundColor = .green
        } else {
            banner.backgroundColor = .red
        }
        banner.duration = 4.0
        banner.show()
    }
    
    static func showBanner(_ subtitle: String,
                           _ style: BannerStyle) {
        DispatchQueue.main.async {
            BannerManager.createBanner(subtitle, style)
        }
    }
}
