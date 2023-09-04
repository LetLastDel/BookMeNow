//
//  ImageGallery.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import SwiftUI
import UIKit

struct ImageGallery: View {
    @State var images: [UIImage]?
    var urls: [String]
    
    var body: some View {
        VStack {
            TabView {
                if let images = images {
                    ForEach(0..<images.count, id: \.self) { img in
                        Image(uiImage: images[img]).resizable()
                            .frame(height: 300)
                            .aspectRatio(contentMode: .fit)
                    }
                } else {
                    Image("imd")
                        .frame(height: 300)
                        .aspectRatio(contentMode: .fit)
                        .blur(radius: 10)
                }
            }.tabViewStyle(PageTabViewStyle())
            .cornerRadius(15)
            .padding(.top, 25)
        }.frame(height: 300)
        .onAppear {
            Task {
                if let newImages = await updateImages(urled: urls) {
                    DispatchQueue.main.async {
                        self.images = newImages
                    }
                }
            }
        }
    }
    private func updateImages(urled: [String]) async -> [UIImage]? {
        var newImages = [UIImage]()
        for url in urled {
            if let fetchImages = try? await NetworkService.shared.dwImage(url: url) {
                newImages.append(fetchImages)
            }
        }
        return newImages
    }
}


struct ImageGallery_Previews: PreviewProvider {
    static var previews: some View {
        ImageGallery(urls: [""])
    }
}
