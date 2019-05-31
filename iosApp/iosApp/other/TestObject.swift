//
//  TestObject.swift
//  iosApp
//
//  Created by Dennis Skokov on 28/05/2019.
//

import Foundation

class TestObject: NSObject {
    let mark: String
    init(mark: String) {
        self.mark = mark
        debugPrint("✅ \(mark)")
    }
    
    deinit {
        debugPrint("❌ \(mark)")
    }
}
