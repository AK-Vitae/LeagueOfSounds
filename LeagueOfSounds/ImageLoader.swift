////
////  ImageLoader.swift
////  LeagueOfSounds
////
////  Created by AK on 7/25/20.
////  Copyright © 2020 AK-Vitae. All rights reserved.
////
//
//import SwiftUI
//
//class ImageLoader: ObservableObject {
//
//    private static let imageCache = NSCache<AnyObject, AnyObject>()
//
//    @Published var image: UIImage? = UIImage(named: "placeholder.png")
//
//    public func downloadImage(url: URL) {
//        let urlString = url.absoluteString
//
//        if let imageFromCache = ImageLoader.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, res, error) in
//            guard let data = data, let image = UIImage(data: data) else {
//                return
//            }
//            DispatchQueue.main.async { [weak self] in
//                ImageLoader.imageCache.setObject(image, forKey: urlString  as AnyObject)
//                self?.image = image
//            }
//        }.resume()
//    }
//}
//
//struct CView: View {
//    @ObservedObject var championImageLoader: ImageLoader = ImageLoader()
//    @ObservedObject var championQImageLoader: ImageLoader = ImageLoader()
//    @ObservedObject var championWImageLoader: ImageLoader = ImageLoader()
//    @ObservedObject var championEImageLoader: ImageLoader = ImageLoader()
//    @ObservedObject var championRImageLoader: ImageLoader = ImageLoader()
//    @ObservedObject var fetch : FetchVersion = FetchVersion()
//    @State var didLoad = 0
//
//    //Make a function that returns a modified string that takes in the version
//    var urlStringChampion : String {
//        get {
//            return "https://ddragon.leagueoflegends.com/cdn/\(self.fetch.version)/img/champion/Aatrox.png"
//        }
//    }
//    var urlStringChampionQ : String {
//        get {
//            return "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/spell/AatroxQ.png"
//        }
//    }
//    var urlStringChampionW : String {
//        get {
//            return "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/spell/AatroxW.png"
//        }
//    }
//    var urlStringChampionE : String {
//        get {
//            return "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/spell/AatroxE.png"
//        }
//    }
//    var urlStringChampionR : String {
//        get {
//            return "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/spell/AatroxR.png"
//        }
//    }
//    var urlS : String {
//        get {
//            return "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/champion/Aatrox.png"
//        }
//    }
//
//    func loadSound() {
//        didLoad = 1
//    }
//
//    var body: some View {
//        VStack(alignment: .center) {
//            if (championImageLoader.image != nil) {
//                Text("Patch: \(self.fetch.version)").padding()
//                //                GeometryReader { geometry in
//                Image(uiImage: self.championImageLoader.image!)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: 200, maxHeight: 200)
//                    .padding()
//                    .onTapGesture {
//                        //print(self.urlStringChampion)
//                        self.championImageLoader.downloadImage(url: URL(string: self.urlStringChampion)!)
//                        self.championQImageLoader.downloadImage(url: URL(string: self.urlStringChampionQ)!)
//                        self.championWImageLoader.downloadImage(url: URL(string: self.urlStringChampionW)!)
//                        self.championEImageLoader.downloadImage(url: URL(string: self.urlStringChampionE)!)
//                        self.championRImageLoader.downloadImage(url: URL(string: self.urlStringChampionR)!)
//                        self.loadSound()
//                        if self.didLoad == 1{
//                            playSound()
//                        }
//                }
//                HStack{
//                    Image(uiImage: self.championQImageLoader.image!)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: 100, maxHeight: 100)
//                        .cornerRadius(12)
//                    Image(uiImage: self.championWImageLoader.image!)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: 100, maxHeight: 100)
//                        .cornerRadius(12)
//                    Image(uiImage: self.championEImageLoader.image!)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: 100, maxHeight: 100)
//                        .cornerRadius(12)
//                    Image(uiImage: self.championRImageLoader.image!)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: 100, maxHeight: 100)
//                        .cornerRadius(12)
//
//                }
//                .padding()
//                //                }
//            }
//        }
//        .cornerRadius(10)
//        .shadow(radius: 20)
//        .onAppear(perform: { self.championImageLoader.downloadImage(url: URL(string: self.urlStringChampion)!)
//        })
//    }
//}
//
//
//struct ImageLoaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        CView()
//    }
//}
