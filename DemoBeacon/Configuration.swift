//
//  Configuration.swift
//  iBeacon Demo
//
//  Created by Darktt on 15/02/13.
//  Copyright (c) 2015年 Darktt. All rights reserved.
//

import Foundation

class iBeaconConfiguration
{
    // You can use uuidgen in terminal to generater new one.
    static let uuid = UUID(uuidString: "00000000-4BF2-1001-B000-001C4D1300D3")!
    static let txPower: Double = -65
    private init() {}
}
