//
//  ProxyDesignPattern.swift
//  DesignPattern
//
//  Created by Saleh Enam Shohag on 15/2/20.
//  Copyright © 2020 Saleh Enam Shohag. All rights reserved.
//

import Foundation

/*
 * ->Proxy design pattern is about controlling and managing access
 * to specific object
 * ->proxy acts as a placeorder for proxied instance
 * ->It introduces an additional label of indirection to support
 * controlled remote or delayed access.
 
 * Why do we need delayed access??
 *1. The object is a resource hub, delay its creation until its
    first access(i.e lazy propery)
 *2. You rely on a remote resource(i.e web service)
 the remote proxy acts as a local placeholder
 
 *3. Uer protective or sensitive resources. protected proxy ensures that
 the caller has appropriate access to the resource. It can expose method to authenticate user or query the access state.
 
 ************************Pitfals*******************
 * 1. Do not expose the proxied types
 * 2. The underline types need to be hidden and the clients only
 use the proxy object
 
 *
 */
import Foundation
class RandomIntWithId {
    var value: Int = {
        print("value initialized")
        return Int.random(in: Int.min...Int.max)
    }()
    lazy var uid: String = {
        print("Uid initialized")
        return UUID.init().uuidString
    }()
}
