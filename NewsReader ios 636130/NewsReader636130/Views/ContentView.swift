

import SwiftUI

struct ContentView: View {
   
    
    
    var body: some View {
            NavigationView{
                    NewsListView(feedId: 0)
                        .navigationTitle(Text("News Feed"))
                        .navigationBarItems(
                        leading:
                            NavigationLink(destination: FilterView()) {
                                Text("Filter")
                        },
                        trailing:
                            NavigationLink(destination: LoginView()) {
                                Image(systemName: "person.fill")
                })
            }
        }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
