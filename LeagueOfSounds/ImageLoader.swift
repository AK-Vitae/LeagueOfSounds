//
//  ImageLoader.swift
//  LeagueOfSounds
//
//  Created by AK on 7/25/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(urlString : String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader : ImageLoader
    @State var image : UIImage = UIImage()
    
    init(withURL url : String) {
        imageLoader = ImageLoader(urlString : url)
    }
    
    var body: some View {
        Image(UIImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:100, height:100)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
        }
    }
}



struct ImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/champion/Aatrox.png")
    }
}
