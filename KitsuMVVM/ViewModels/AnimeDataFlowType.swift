//
//  AnimeDataFlowType.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation

protocol AnimeDataFlowType {
    associatedtype InputType
    associatedtype OutputType
    
    func apply(_ input: InputType)
    var output: OutputType { get }
}
