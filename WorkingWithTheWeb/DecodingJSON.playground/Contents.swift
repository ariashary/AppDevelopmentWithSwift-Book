import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            (URLQueryItem(name: $0.0, value: $0.1))
        }
        return components?.url
    }
}

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    
    init(from decoder: Decoder) throws {
        let valueConteiner = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try valueConteiner.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueConteiner.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueConteiner.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueConteiner.decode(String.self, forKey: CodingKeys.copyright)
    }
}

func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
    let baseUrl = URL(string: "https://api.nasa.gov/planetary/apod")!
    
    let query: [String: String] = [
        "api_key": "DEMO_KEY",
    ]
    
    let url = baseUrl.withQueries(query)
    let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
            let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
            print(photoInfo)
            completion(photoInfo)
        } else {
            print("Either no data was returned, or data was not properly decoded")
            completion(nil)
        }
        PlaygroundPage.current.finishExecution()
    }
    task.resume()
}

fetchPhotoInfo { (fetchedInfo) in
    print(fetchedInfo)
}
