//
//  BuilderDesignPattern.swift
//  DesignPattern
//
//  Created by Saleh Enam Shohag on 31/1/20.
//  Copyright © 2020 Saleh Enam Shohag. All rights reserved.
//

import UIKit

class BuilderDesignPattern: NSObject {

}

public class Pizza {
    private var size: Int
    private var cheese: Bool
    private var pepperoni: Bool
    private var bacon: Bool
    
    public class Builder {
        internal var size: Int
        internal var cheese: Bool = false
        internal var pepperoni: Bool = false
        internal var bacon: Bool = false
        
        init(size: Int){
            self.size = size
        }
        public func cheese(value: Bool) -> Builder{
            self.cheese = value
            return self
        }
        public func pepperoni(value: Bool) -> Builder{
            self.pepperoni = value
            return self
        }
        public func bacon(value: Bool) -> Builder{
            self.bacon = value
            return self
        }
        public func build() -> Pizza {
            return Pizza(builder: self)
        }
    }
    private init(builder: Builder){
        self.size = builder.size
        self.cheese = builder.cheese
        self.bacon = builder.bacon
        self.pepperoni = builder.pepperoni
    }
}
