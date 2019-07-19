//
//  AnimeAttributesModel.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation
import SwiftUI

struct AnimeAttributesModel : Decodable, Hashable {
    var createdAt: String?
    var updatedAt: String?
    var slug: String
    var synopsis: String
    var canonicalTitle: String
    var status: String
    var posterImage: AnimePosterImageModel
}
