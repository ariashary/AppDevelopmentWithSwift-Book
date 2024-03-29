import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

let baseUrl = URL(string: "https://itunes.apple.com/search?")!

let query: [String: String] = [
    "term": "steve jobs",
    "media": "ebook",
    "limit": "20"
]

let url = baseUrl.withQueries(query)
let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
    if let string = String(data: data!, encoding: .utf8) {
        print(string)
    }
    PlaygroundPage.current.finishExecution()
}
task.resume()
