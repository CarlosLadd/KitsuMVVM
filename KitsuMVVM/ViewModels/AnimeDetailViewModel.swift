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

final class AnimeDetailViewModel: ObservableObject {
    let objectWillChange: AnyPublisher<AnimeListViewModel, Never>
    let objectWillChangeSubject = PassthroughSubject<AnimeListViewModel, Never>()
    
    let anime: AnimeModel
    
    init(anime: AnimeModel) {
        objectWillChange = objectWillChangeSubject.eraseToAnyPublisher()
        self.anime = anime
    }
}
