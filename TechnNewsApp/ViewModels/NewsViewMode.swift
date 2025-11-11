import Foundation
import Combine

@MainActor
final class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: NewsServicing
    private var hasLoadedOnce = false

    init(service: NewsServicing = NewsService()) {
        self.service = service
    }

    // cargar noticias si no se han cargado
    func loadIfNeeded() async {
        guard !hasLoadedOnce else { return }
        hasLoadedOnce = true
        await reload()
    }
    
    func reload() async {
        isLoading = true
        errorMessage = nil
        do {
            articles = try await service.fetchTechnologyNews(limit: 30)
        } catch {
            errorMessage = "Error no se puderion cargar las noticias correctramente."
        }
        isLoading = false
    }
    
        
}
