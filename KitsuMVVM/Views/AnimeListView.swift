//
//  animeListView.swift
//  KitsuMVVM
//
//  Created by Carlos Landaverde on 7/18/19.
//  Copyright © 2019 Carlos Landaverde. All rights reserved.
//

import SwiftUI

struct AnimeListView : View {
    @ObservedObject var viewModel: AnimeListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.output.animes) { anime in
                AnimeListRow(anime: anime)
            }
            .alert(isPresented: $viewModel.isErrorShown) { () -> Alert in
                Alert(title: Text("Error"), message: Text(viewModel.output.errorMessage))
            }
            .navigationBarTitle(Text("Anime List"))
        }
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

#if DEBUG
struct AnimeListView_Previews : PreviewProvider {
    static var previews: some View {
        AnimeListView(viewModel: .init())
    }
}
#endif
