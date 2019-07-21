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
    @ObjectBinding var viewModel: AnimeDetailViewModel
    
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            ImageViewRow(animePosterURL: viewModel.anime.attributes.posterImage.small, imageSize: 150.0)
            
            Text(viewModel.anime.attributes.canonicalTitle).bold().lineLimit(nil).padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            Text("Slug: " + viewModel.anime.attributes.slug)
            Text("Status: " + viewModel.anime.attributes.status)
            
            Text(viewModel.anime.attributes.synopsis).lineLimit(nil).padding(16)
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
