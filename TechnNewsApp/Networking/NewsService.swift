

import Foundation

//Función para obtener noticias de una API

protocol NewsServicing {
    func fetchTechnologyNews(limit: Int) async throws -> [Article]
}

struct NewsService: NewsServicing {
    func fetchTechnologyNews(limit: Int = 30) async throws -> [Article] {
        var components = URLComponents(string: "https://hn.algolia.com/api/v1/search_by_date")!
        components.queryItems = [
            URLQueryItem(name: "query", value: "technology"),
            URLQueryItem(name: "tags", value: "story"),
            URLQueryItem(name: "hitsPerPage", value: String(limit))
        ]
        
        let url = components.url!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let payload = try decoder.decode(APIResponse.self, from: data)
        return payload.hits
    }
}
