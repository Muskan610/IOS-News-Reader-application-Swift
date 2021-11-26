

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @StateObject var viewModel = RegisterViewModelImpl(service: RegisterServiceImpl())
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                switch viewModel.state{
                case .failed:
                    Text("Something went wrong :(").foregroundColor(.red).padding(.bottom, 8)
                case .noAttemptYet:
                    EmptyView().padding(.bottom, 8)
                case .loading:
                    EmptyView().padding(.bottom, 8)
                case .successRegister(content: let content):
                    switch content.Success{
                        case true:
                            EmptyView().padding(.bottom, 8)
                        case false:
                            Text(content.Message).foregroundColor(.red).padding(.bottom, 8)
                    }
                }
                VStack(alignment: .leading){
                Text("User name")
                TextField("User name", text: $username)
                }.padding(.bottom, 20)
                VStack(alignment: .leading){
                    Text("Password")
                    SecureField("Password", text: $password)
                }.padding(.bottom, 20)
                Button("Register"){
                    self.viewModel.register(username: username, password: password)
                    username = ""
                    password = ""
                }.padding(.vertical, 12).padding(.horizontal, 30).background(Color.blue).foregroundColor(.white).font(.system(size: 15, weight: .heavy)).cornerRadius(10)
                Spacer()
            }.padding(.leading, 50)
        }.navigationTitle("Register")
        NavigationLink(destination: LoginView()){
            Text("Already have an account? Login here!").padding(.top, 10)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
