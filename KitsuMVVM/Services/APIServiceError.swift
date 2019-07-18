//
//  APIServiceError.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation

enum APIServiceError : Error {
    case responseError
    case parseError(Error)
}
