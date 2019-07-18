//
//  AnimeModel.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation
import SwiftUI

struct AnimeModel : Decodable, Hashable, Identifiable {
    var id: String = ""
    var type: String
    var attributes: AnimeAttributesModel
}
