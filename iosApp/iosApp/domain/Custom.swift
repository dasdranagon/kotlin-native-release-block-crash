//
//  Custom.swift
//  iosApp
//
//  Created by Dennis Skokov on 28/05/2019.
//

import Foundation
import app
import FW

class CustomFactory: Factory {
    func listener(block: @escaping (Any) -> KotlinUnit) -> Removable {
        let to = TestObject(mark: "listenet T.O.")
        return NoARCListener { _ in
            debugPrint("\(to)")
            _ = block(to)
        }
    }
}
