//
//  ImageGallery.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import SwiftUI

struct ImageGallery: View {
    @State var backgroundOffset: CGFloat = 0
    @State var images: [UIImage]?
    var urls: [String]
    
    var body: some View {
        VStack{
            GeometryReader { proxy in
                if let images = images {
                    HStack(spacing: 0) {
                        ForEach(0..<images.count, id: \.self) { img in
                            Image(uiImage: images[img])
                                .resizable()
                                .frame(width: proxy.size.width, height: proxy.size.height)
                                .aspectRatio(contentMode: .fit)
                        }
                        .offset(x: -(self.backgroundOffset * proxy.size.width))
                    }
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 75, height: 17)
                            .cornerRadius(5)
                        HStack {
                            ForEach(0..<images.count, id: \.self) { index in
                                Circle()
                                    .fill(getColor(index: index, offset: backgroundOffset))
                                    .frame(width: 7, height: 7)
                            }
                        }
                    }.position(x: proxy.size.width/2, y: proxy.size.height/1.1)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width > 10 {
                            if self.backgroundOffset > 0 {
                                withAnimation {
                                    self.backgroundOffset -= 1
                                }
                            }
                        } else if value.translation.width < -10 {
                            if self.backgroundOffset < CGFloat((images?.count ?? 0) - 1) {
                                withAnimation {
                                    self.backgroundOffset += 1
                                }
                            }
                        }
                    }
            )
            .onAppear {
                Task {
                    if let newImages = await updateImages(urled: urls) {
                        DispatchQueue.main.async {
                            self.images = newImages
                        }
                    }
                }
            }
        }.frame(height: 273)
            .cornerRadius(15)
    }
}

private func getColor(index: Int, offset: CGFloat) -> Color {
    let diff = abs(offset - CGFloat(index))
    switch diff {
    case 0:
        return Color.black
    case 1:
        return Color.gray.opacity(0.22)
    case 2:
        return Color.gray.opacity(0.17)
    case 3:
        return Color.gray.opacity(0.10)
    default:
        return Color.gray.opacity(0.5)
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


