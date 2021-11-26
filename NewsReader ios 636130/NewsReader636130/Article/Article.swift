

import Foundation

struct NewsResponse: Codable {
    let Results: [Article]
}

struct Article: Codable, Identifiable {
    let uuid = UUID()
    let id: Int
    let feed: Int
    let title: String
    let summary: String
    let publishDate: String
    let image: String
    let url: String
    let related: [String]
    let categories: [NewsCategory]?
    let isLiked: Bool
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case feed = "Feed"
        case title = "Title"
        case summary = "Summary"
        case publishDate = "PublishDate"
        case image = "Image"
        case url = "Url"
        case related = "Related"
        case categories = "Categories"
        case isLiked = "IsLiked"
    }
    
    init(id: Int, feed: Int, title: String, summary: String, publishDate: String, image: String, url: String, related: [String], categories: [NewsCategory]?, isLiked: Bool){
        self.id = id
        self.feed = feed
        self.title = title
        self.summary = summary
        self.publishDate = publishDate
        self.image = image
        self.url = url
        self.related = related
        self.categories = categories
        self.isLiked = isLiked
    }
    
    
}

struct NewsCategory: Codable {
    let Id: Int
    let Name: String
    
    enum CodingKeys: String, CodingKey{
        case Id, Name
    }
}

struct NewsFeed: Identifiable {
    let id = UUID()
    let feedId: Int
    let name: String
}



extension Article{
    static var dummyData: Article {
        .init(id: 666666,
              feed: 1,
              title: "Title",
              summary: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
              publishDate: "2021-12-12T18:14:07",
              image:"https://media1.jpc.de/image/w600/rear/0/0602435988511.jpg",
              url: "https://k-pop.fandom.com/de/wiki/BTS",
              related: [],
              categories: [NewsCategory(Id: 4270, Name: "Sport"), NewsCategory(Id: 4271, Name: "Wielrennen")],
              isLiked: false)
    }
}
