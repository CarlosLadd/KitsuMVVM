//
//  AnimeDetailViewModel.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AnimeDetailViewModel: BindableObject {
    let willChange: AnyPublisher<AnimeListViewModel, Never>
    let willChangeSubject = PassthroughSubject<AnimeListViewModel, Never>()
    
    let anime: AnimeModel
    
    init(anime: AnimeModel) {
        willChange = AnyPublisher(willChangeSubject)
        self.anime = anime
    }
}
