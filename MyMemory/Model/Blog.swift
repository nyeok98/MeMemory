//
//  Blog.swift
//  MyMemory
//
//  Created by 신동녘 on 2023/01/10.
//

import UIKit

struct Blog: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case body
        case gradientColor = "gradient_color"
        case photo
    }
    
    var title: String
    var body: String
    var gradientColor: [String]
    var photo: String
    
    init(from decoder: Decoder) throws {
        let containers = try decoder.container(keyedBy: CodingKeys.self)
        title = (try? containers.decode(String.self, forKey: .title)) ?? ""
        body = (try? containers.decode(String.self, forKey: .body)) ?? ""
        gradientColor = (try? containers.decode([String].self, forKey: .gradientColor)) ?? ["#000"]
        photo = (try? containers.decode(String.self, forKey: .photo)) ?? ""
    }
    
}
