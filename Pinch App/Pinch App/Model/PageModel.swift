//
//  PageModel.swift
//  Pinch App
//
//  Created by Admin on 20/12/22.
//

import Foundation

struct page : Identifiable {
    let id: Int
    let imageName : String
}

extension page{
    var thumbnailName : String {
        return "thumb-"+imageName
    }
}
