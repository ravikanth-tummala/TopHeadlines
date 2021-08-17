//
//  AsyncImageList.swift
//  Top Headlines
//
//  Created by GeoSpark on 09/08/21.
//

import SwiftUI


@available(iOS 15, *)

struct AsyncImageList<Content,Placeholder>:View where Content:View, Placeholder:View {
    let url:URL?
    let content:(Image) -> Content
    let placeholder:() -> Placeholder

    @State private var currentURL:URL?
    
    var body: some View{
        AsyncImage(url: url, content: content, placeholder: placeholder)
            .onAppear{
                if currentURL == nil{
                    DispatchQueue.main.async {
                        currentURL = url
                    }
                }
            }
    }

}
