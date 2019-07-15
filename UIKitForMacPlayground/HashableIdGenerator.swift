//
//  HashableIdGenerator.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation

/// Generates a process-unique stream of ints. Used for buttonn identification in ExamplesViewController.
enum HashableIdGenerator {
    private static var nextId = 0

    static func next() -> Int {
        nextId += 1
        return nextId
    }
}
