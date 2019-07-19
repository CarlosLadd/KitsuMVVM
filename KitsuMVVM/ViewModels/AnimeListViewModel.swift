//
//  AnimeListViewModel.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AnimeListViewModel: BindableObject, AnimeDataFlowType {
    typealias InputType = Input
    typealias OutputType = Output
    
    let didChange: AnyPublisher<Void, Never>
    private let didChangeSubject = PassthroughSubject<Void, Never>()
    private var cancellables: [AnyCancellable] = []
    
    // MARK: Input
    
    enum Input {
        case onAppear
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }
    
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    
    // MARK: Output
    
    struct Output {
        var animes: [AnimeModel] = []
        var isErrorShown = false
        var errorMessage = ""
        var shouldShowIcon = false
    }
    
    private(set) var output = Output() {
        didSet {
            didChangeSubject.send(())
        }
    }
    
    var isErrorShown: Bool {
        get { return output.isErrorShown }
        set { output.isErrorShown = newValue }
    }
    
    private let responseSubject = PassthroughSubject<SearchAnimeModel, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let trackingSubject = PassthroughSubject<TrackEventType, Never>()
    
    private let apiService: APIServiceType
    private let trackerService: TrackerType
    
    init(apiService: APIServiceType = APIService(),
         trackerService: TrackerType = TrackerService()) {
        self.apiService = apiService
        self.trackerService = trackerService
        
        didChange = didChangeSubject.eraseToAnyPublisher()
        
        bindInputs()
        bindOutputs()
    }
    
    private func bindInputs() {
        let request = SearchAnimeRequest()
        let responsePublisher = onAppearSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request)
                    .catch { [weak self] error -> Publishers.Empty<SearchAnimeModel, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }
        
        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        _ = trackingSubject
            .sink(receiveValue: trackerService.log)
        
        let trackingStream = onAppearSubject
            .map { .listView }
            .subscribe(trackingSubject)
        
        cancellables += [
            responseStream,
            trackingStream
        ]
    }
    
    private func bindOutputs() {
        let animesStream = responseSubject
            .map { $0.data }
            .assign(to: \.output.animes, on: self)
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                switch error {
                case .responseError: return "network error"
                case .parseError: return "parse error"
                }
        }
        .assign(to: \.output.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.output.isErrorShown, on: self)
        
        cancellables += [
            animesStream,
            errorStream,
            errorMessageStream
        ]
    }
}
