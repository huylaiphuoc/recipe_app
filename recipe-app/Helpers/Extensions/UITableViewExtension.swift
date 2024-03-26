//
//  UITableViewExtension.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import UIKit

extension UITableView {

    // MARK: Reusable Cell
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        NSLog(className)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
    }
}
