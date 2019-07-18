//
//  ExperimentServiceType.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation

protocol ExperimentServiceType {
    func experiment(for key: ExperimentKey) -> Bool
}
