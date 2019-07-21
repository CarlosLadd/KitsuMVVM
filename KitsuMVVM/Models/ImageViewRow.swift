//
//  ImageRow.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct ImageViewRow: View {
    let animePosterURL: String
    let imageSize: CGFloat
    
    var body: some View {
        VStack(alignment: .center) {
            ImageViewContainer(imageUrl: animePosterURL, size: imageSize)
        }
    }
}

struct ImageViewContainer: View {
    @ObjectBinding var remoteImageURL: DownloadTaskImageURL
    let imageSize: CGFloat
    
    init(imageUrl: String, size: CGFloat) {
        remoteImageURL = DownloadTaskImageURL(imageURL: imageUrl)
        imageSize = size
    }
    
    var body: some View {
        Image(uiImage: UIImage(data: remoteImageURL.data) ?? UIImage())
            .resizable()
            .clipShape(Circle())
            .frame(width: imageSize, height: imageSize)
    }
}

class DownloadTaskImageURL: BindableObject {
    var willChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            willChange.send(data)
        }
    }
    
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async { self.data = data }
        }.resume()
    }
}
