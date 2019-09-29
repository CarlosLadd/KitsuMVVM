//
//  AnimeDetailView.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation
import SwiftUI

struct AnimeDetailView: View {
    @ObservedObject var viewModel: AnimeDetailViewModel
    
    var body: some View {
        VStack (alignment: .center) {
            ImageViewRow(animePosterURL: viewModel.anime.attributes.posterImage.small, imageSize: 150.0)
            Text(viewModel.anime.attributes.canonicalTitle).bold().lineLimit(2).padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            
            Text("Slug: " + viewModel.anime.attributes.slug)
            Text("Status: " + viewModel.anime.attributes.status)
            Text(viewModel.anime.attributes.synopsis).padding(16).lineLimit(Int.max)
            
            Spacer()
        }
    }
}

#if DEBUG
struct AnimeDetailView_Previews : PreviewProvider {
    static var previews: some View {
        AnimeDetailView(viewModel: .init(
            anime: AnimeModel(
                id: "1",
                type: "test",
                attributes: AnimeAttributesModel(createdAt: "18/07/2019",
                                                 updatedAt: "18/07/2019",
                                                 slug: "demo slug",
                                                 synopsis: "demo anime",
                                                 canonicalTitle: "Demo Anime",
                                                 status: "Finished",
                                                 posterImage: AnimePosterImageModel(tiny: "", small: ""))
        ))
        )
    }
}
#endif
