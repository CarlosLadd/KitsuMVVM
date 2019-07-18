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
    let didChange: AnyPublisher<AnimeListViewModel, Never>
    let didChangeSubject = PassthroughSubject<AnimeListViewModel, Never>()
    
    let anime: AnimeModel
    
    init(anime: AnimeModel) {
        didChange = AnyPublisher(didChangeSubject)
        self.anime = anime
    }
}
