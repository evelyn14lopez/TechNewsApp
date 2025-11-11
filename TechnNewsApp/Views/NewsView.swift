import SwiftUI

struct NewsView: View {
    @StateObject private var viewModel = NewsViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                Group {
                    if viewModel.isLoading {
                        ProgressView("Cargando noticias…")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

                    } else if let message = viewModel.errorMessage {
                        VStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 34))
                                .foregroundStyle(.orange)
                            Text(message)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            Button {
                                Task { await viewModel.reload() }
                            } label: {
                                Label("Reintentar", systemImage: "arrow.clockwise")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

                    } else if viewModel.articles.isEmpty {
                        // Estado vacío (por si la API devuelve 0)
                        ContentUnavailableView(
                            "Sin resultados",
                            systemImage: "newspaper",
                            description: Text("No encontramos titulares por ahora. Desliza hacia abajo para actualizar.")
                        )
                    } else {
                        List {
                            ForEach(viewModel.articles) { article in
                                ArticleRowView(article: article)
                                    .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .refreshable { await viewModel.reload() }
                    }
                }
            }
            .navigationTitle("Tech News")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task { await viewModel.reload() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .accessibilityLabel("Actualizar noticias")
                }
            }
        }
        .task { await viewModel.loadIfNeeded() }
        .animation(.easeOut(duration: 0.2), value: viewModel.articles.count)
    }
}

#Preview {
    NewsView()
}
