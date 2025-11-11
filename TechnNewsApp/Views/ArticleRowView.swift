import SwiftUI

struct ArticleRowView: View {
    let article: Article

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.blue.opacity(0.8), .purple.opacity(0.8)],
                                         startPoint: .topLeading, endPoint: .bottomTrailing))
                Text(String(article.author.prefix(1)).uppercased())
                    .font(.headline).bold()
                    .foregroundStyle(.white)
            }
            .frame(width: 36, height: 36)
            .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 8) {
                // Título
                Text(article.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                // Metadatos
                HStack(spacing: 8) {
                    Text(article.author)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("•")
                        .foregroundStyle(.secondary)

                    Text(article.createdAt, style: .relative)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if let urlString = article.url, let url = URL(string: urlString) {
                    HStack(spacing: 6) {
                        Link(destination: url) {
                            Text(url.host ?? urlString)
                                .font(.footnote)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule()
                                        .fill(Color.secondary.opacity(0.12))
                                )
                        }
                        .buttonStyle(.plain)
                        .accessibilityHint("Abrir enlace en el navegador")
                    }
                }
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        .contentShape(Rectangle())
        .padding(.vertical, 4)
    }
}

#Preview {
    ArticleRowView(article: .init(
        id: "1",
        title: "Ejemplo de titular tecnológico muy interesante y bastante largo",
        url: "https://example.com/post",
        author: "jane_doe",
        createdAt: Date().addingTimeInterval(-3600)
    ))
    .padding()
}
