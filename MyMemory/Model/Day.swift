//
//  Day.swift
//  MyMemory
//
//  Created by NYEOK on 2023/01/14.
//

import Foundation

struct Day: Codable {
    let title: String
    let body: String
    let imageURL: String?
    let date: String
   
    enum CodingKeys: String, CodingKey {
        case title, body, date
        case imageURL = "image_url"
    }
    
    init(title: String, body: String, imageURL: String?) {
        self.title = title
        self.body = body
        self.imageURL = imageURL
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        self.date = result
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        body = try values.decode(String.self, forKey: .body)
        imageURL = try values.decode(String.self, forKey: .imageURL)
        date = try values.decode(String.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(date, forKey: .date)
    }
}

