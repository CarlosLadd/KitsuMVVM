//
//  SearchAnimeRequest.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation

struct SearchAnimeRequest: APIRequestType {
    typealias Response = SearchAnimeModel
    
    var path: String { return "anime?" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "page%5Blimit%5D", value: "10"),
            .init(name: "page%5Boffset%5D", value: "0")
        ]
    }
}
