import Foundation
/*
{
  "hits": [
    {
      "title": "Some tech headline",
      "url": "https://example.com/post",
      "author": "johndoe",
      "created_at": "2024-11-01T12:34:56.000Z",
      "objectID": "123456"
    }
  ]
}
*/

struct APIResponse: Decodable {
    let hits: [Article]
}

struct Article: Identifiable, Decodable {
    let id: String
    let title: String
    let url: String?
    let author: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case title
        case url
        case author
        case createdAt = "created_at"
    }
}
