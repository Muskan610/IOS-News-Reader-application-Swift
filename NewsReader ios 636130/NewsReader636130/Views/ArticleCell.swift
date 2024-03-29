

import SwiftUI
import URLImage

struct ArticleCell: View {
    let article: Article
    
    
    var body: some View {
            HStack(alignment: .center){
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
                        case 1: Image(systemName: "newspaper").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                        case 2: Image(systemName: "network").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                        case 3: Image(systemName: "sportscourt").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                            case 4: Image(systemName: "questionmark.square").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                            case 5: Image(systemName: "gamecontroller").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                            case 6: Image(systemName: "brain.head.profile").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                        default:
                            Image(systemName: "jiminie")
                        }
                    }
                    
                    failure: { error, _ in
                        Image(systemName: "photo.fill")
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .frame(width: 100, height: 100)
                    }
                    
                    content: {
                        image in image.resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100).cornerRadius(10)
                    }
                             
                }
                else{
                    Image(systemName: "photo.fill")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .frame(width: 100, height: 100)
                }
                Text(article.title)
                Spacer()
            }.padding(.horizontal, 5).padding(.vertical, 5)
        }
    }


struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell(article: Article.dummyData)
    }
}
