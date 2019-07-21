//
//  AnimeListRow.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import Foundation
import SwiftUI

struct AnimeListRow: View {
    
    @State var anime: AnimeModel
    
    var body: some View {
        NavigationLink(destination: AnimeDetailView(viewModel: .init(anime: anime))) {
            VStack (alignment: .leading, spacing: 10) {
                HStack {
                    ImageViewRow(animePosterURL: anime.attributes.posterImage.tiny, imageSize: 75.0).aspectRatio(contentMode: .fit)
                    VStack (alignment: .leading) {
                        Text(anime.attributes.canonicalTitle).bold().lineLimit(2)
                        Text(anime.attributes.synopsis).lineLimit(3)
                    }
                }
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        }
    }
}

#if DEBUG
struct AnimeListRow_Previews : PreviewProvider {
    static var previews: some View {
        AnimeListRow(anime:
            AnimeModel(
                id: "1",
                type: "test",
                attributes: AnimeAttributesModel(createdAt: "18/07/2019",
                                                 updatedAt: "18/07/2019",
                                                 slug: "test slug",
                                                 synopsis: "demo-anime",
                                                 canonicalTitle: "Demo Anime",
                                                 status: "Finished",
                                                 posterImage: AnimePosterImageModel(tiny: "", small: ""))
            )
        )
    }
}
#endif
