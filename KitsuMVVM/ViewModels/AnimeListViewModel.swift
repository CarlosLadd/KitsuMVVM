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

final class AnimeListViewModel: ObservableObject, AnimeDataFlowType {
    typealias InputType = Input
    typealias OutputType = Output
    
    // MARK: Subjects
    
    private var cancellables: [AnyCancellable] = []
    let objectWillChange: AnyPublisher<Void, Never>
    private let objectWillChangeSubject = PassthroughSubject<Void, Never>()
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let responseSubject = PassthroughSubject<SearchAnimeModel, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let trackingSubject = PassthroughSubject<TrackEventType, Never>()
    
    // MARK: Input
    
    enum Input {
        case onAppear
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }
    
    // MARK: Output
    
    struct Output {
        var animes: [AnimeModel] = []
        var isErrorShown = false
        var errorMessage = ""
        var shouldShowIcon = false
    }
    
    private(set) var output = Output() {
        didSet {
            objectWillChangeSubject.send(())
        }
    }
    
    var isErrorShown: Bool {
        get { return output.isErrorShown }
        set { output.isErrorShown = newValue }
    }
    
    // MARK: Services
    
    private let apiService: APIServiceType
    private let trackerService: TrackerType
    
    // MARK: Initializer
    
    init(apiService: APIServiceType = APIService(),
         trackerService: TrackerType = TrackerService()) {
        self.apiService = apiService
        self.trackerService = trackerService
        
        objectWillChange = objectWillChangeSubject.eraseToAnyPublisher()
        
        bindInputs()
        bindOutputs()
    }
    
    private func bindInputs() {
        let request = SearchAnimeRequest()
        
        let responsePublisher = onAppearSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request)
                    .catch { [weak self] error -> Empty<SearchAnimeModel, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }
        
        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        let trackingSubjectStream = trackingSubject
            .sink(receiveValue: trackerService.log)
        
        let trackingStream = onAppearSubject
            .map { .listView }
            .subscribe(trackingSubject)
        
        cancellables += [
            responseStream,
            trackingSubjectStream,
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
                case .responseError: return "Network error"
                case .parseError: return "Parse error"
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
