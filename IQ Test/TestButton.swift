//
//  TestButton.swift
//  IQ Test
//
//  Created by Admin on 22.08.17.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class TestButton: UIButton {

    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 15

    }
}
