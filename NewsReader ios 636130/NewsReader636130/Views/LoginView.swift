
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    private let localStorage: LocalStorage = .init()
    
    @StateObject var viewModel = LoginViewModelImpl(service: LoginServiceImpl())

    var body: some View {
        let authToken = localStorage.fetchAuthToken()
        switch authToken{
            case "":
                NavigationView{
                    
                    VStack(alignment: .leading){
                        switch viewModel.state{
                            case .failed:
                            Text("Wrong Credentials").foregroundColor(.red).padding(.bottom, 8)
                        case .noAttemptYet:
                            EmptyView().padding(.bottom, 8)
                        case .loading:
                            EmptyView().padding(.bottom, 8)
                        case .successLogin(content: _):
                            EmptyView().padding(.bottom, 8)
                        }
                        VStack(alignment: .leading){
                        Text("Username")
                        TextField("Username", text: $username)
                        }.padding(.bottom, 20)
                        VStack(alignment: .leading){
                            Text("Password")
                            SecureField("Password", text: $password)
                        }.padding(.bottom, 20)
                        Button("Login"){
                            self.viewModel.login(username: username, password: password)
                            username = ""
                            password = ""
                        }.padding(.vertical, 12).padding(.horizontal, 30).background(Color.blue).foregroundColor(.white).font(.system(size: 15, weight: .heavy)).cornerRadius(10)
                        Spacer()
                    }.padding(.leading, 50)
                    
                }.navigationTitle("Log in")
            
            NavigationLink(destination: RegisterView()){
                Text("Dont have an account yet? Register here!").padding(.top, 10)
            }
            default:
            NavigationView{
                VStack{
                    Text("User logged in")
                    Button("Logout"){
                        viewModel.logout()
                    }.padding(.vertical, 12).padding(.horizontal, 30).background(Color.blue).foregroundColor(.white).font(.system(size: 15, weight: .heavy)).cornerRadius(10)
                }
                
            }.navigationTitle("Profile").navigationBarItems(trailing:
                NavigationLink(destination: LikedArticleView()){
                    Image(systemName: "heart.fill")
                }
            )  
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
