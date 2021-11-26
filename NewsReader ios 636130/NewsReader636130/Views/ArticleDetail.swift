

import SwiftUI
import URLImage

struct ArticleDetail: View {
    @StateObject var viewModel = DetailViewModelImpl(service: ArticleServiceImpl())
    let article: Article
    private let localStorage: LocalStorage = .init()
    
    var body: some View {
        let token = localStorage.fetchAuthToken()
        let splitDate = article.publishDate.split(separator: "T")
        let time = String(splitDate[1])
        let date = String(splitDate[0])
        var likedStatus = article.isLiked
        
        ScrollView{
            VStack(alignment: .leading){
                if let imgUrl = article.image,
                   let url = URL(string: imgUrl){
                    
                    URLImage(url){
                        switch article.feed{
                        case 1: Image(systemName: "newspaper")
                        case 2: Image(systemName: "network")
                        case 3: Image(systemName: "sportscourt")
                        case 4: Image(systemName: "questionmark.square")
                        case 5: Image(systemName: "gamecontroller")
                        case 6: Image(systemName: "brain.head.profile")
                        default:
                            Image(systemName: "jiminie")
                        }
                    }
                inProgress: {
                    progress in
                    switch article.feed{
                    case 1: Image(systemName: "newspaper").resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 350)
                    case 2: Image(systemName: "network").resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 350)
                    case 3: Image(systemName: "sportscourt").resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 350)
                    case 4: Image(systemName: "questionmark.square").resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 350)
                    case 5: Image(systemName: "gamecontroller").resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 350)
                    case 6: Image(systemName: "brain.head.profile").resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 350)
                    default:
                        
                        Image(systemName: "jiminie")
                    }
                }
                    
                failure: { error, _ in
                    Image(systemName: "photo.fill")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 350)
                }
                    
                content: {
                    image in image.resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity, maxHeight: 350).cornerRadius(1)
                }
                .padding(.horizontal, 20.0)
                    
                }
                else{
                    Image(systemName: "photo.fill")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 250)
                }
                
                
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Published on \(date) at \(time)").font(.caption).padding(.top)
                        Text(article.title).font(.title2).fontWeight(.bold).padding(.vertical, 6.0)
                        Text(article.summary)
                    }.padding(.leading, 10)
                    HStack{
                        Spacer()
                        if(token != ""){
                            switch viewModel.state{
                                
                            case .noAttemptYet:
                                if(!article.isLiked){
                                    Button("Like"){
                                        viewModel.like(articleId: self.article.id)
                                    }.padding(.vertical, 12)
                                        .padding(.horizontal, 30)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .heavy))
                                        .cornerRadius(10)
                                }
                                else{
                                    Button("Unlike"){
                                        viewModel.unlike(articleId: self.article.id)
                                    }.padding(.vertical, 12)
                                        .padding(.horizontal, 30)
                                        .background(Color.white)
                                        .foregroundColor(.red)
                                        .font(.system(size: 15, weight: .heavy))
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).fill(Color.red))
                                }
                            case .failed(error: let error):
                                Text(error.localizedDescription)
                            
                            case .successLiked:
                                Button("Unlike"){
                                    viewModel.unlike(articleId: self.article.id)
                                }.padding(.vertical, 12)
                                    .padding(.horizontal, 30)
                                    .background(Color.white)
                                    .foregroundColor(.red)
                                    .font(.system(size: 15, weight: .heavy))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).fill(Color.red))
                                
                            case .successUnliked:
                                Button("Like"){
                                    viewModel.like(articleId: self.article.id)
                                }   .padding(.vertical, 12)
                                    .padding(.horizontal, 30)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .heavy))
                                    .cornerRadius(10)
                                
                            }
                        }
                        else{
                            Text("Login/Register to save your favourite articles!")
                                .fontWeight(.semibold)
                        }
                        
                        Button("Read"){
                            UIApplication.shared.open(URL(string: self.article.url)!)
                        }.padding(.vertical, 12).padding(.horizontal, 30).background(Color.orange).foregroundColor(.white).font(.system(size: 15, weight: .heavy)).cornerRadius(10)
                        
                        Button("Share"){
                            guard let urlShare = URL(string: self.article.url) else { return }
                                    let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
                                    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                        }.padding(.vertical, 12).padding(.horizontal, 30).background(Color.green).foregroundColor(.white).font(.system(size: 15, weight: .heavy)).cornerRadius(10)
                        
                        
                        Spacer()
                        
                    }.padding(.vertical, 15.0)
                }
            }
        }
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(article: Article.dummyData)
    }
}
