//
//  ScalarFilterParameter.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/12/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

struct ScalarFilterParameter
{
    var name: String?
    var key: String
    var minimumValue: Float?
    var maximumValue: Float?
    var currentValue: Float

    init(key: String, value: Float) {
        self.key = key
        self.currentValue = value
    }

    init(name: String, key: String, minimumValue: Float, maximumValue: Float, currentValue: Float)
    {
        self.name = name
        self.key = key
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self.currentValue = currentValue
    }
}
