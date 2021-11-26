

import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    let feedId: Int
    var body: some View {
        
        let feedTitle = { () -> String in
            switch feedId{
                case 1:
                    return "Generel/Algemeen"
                case 2:
                    return "Internet"
                case 3:
                    return "Sport"
                case 4:
                    return "Remarkable/Opmerkelijk"
                case 5:
                    return "Games"
                case 6:
                    return "Sciene/Wetenschap"

            default:
                return "News Feed"
            }
            
        }()
        
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: { viewModel.getArticles(feedId: feedId) })
            case .success(let articles):
                    List(articles) {
                        item in
                        NavigationLink(destination: ArticleDetail(article: item)){
                            HStack{
                                ArticleCell(article: item)
                                
                                
                            }
                        }
                    }.navigationTitle(feedTitle)
                    
            }
        }.onAppear(perform: {
            viewModel.getArticles(feedId:feedId) })
        }
    }

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(feedId: 0)
    }
}
