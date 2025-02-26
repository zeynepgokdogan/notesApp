import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                 Form {
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage).foregroundStyle(.red)
                    }
                     TextField("Name", text: $viewModel.name)
                         .autocorrectionDisabled(true)
                         .textInputAutocapitalization(.none)
                    TextField("Surname", text: $viewModel.surname)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    TextField("Email", text: $viewModel.email )
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    SecureField("Password", text: $viewModel.password )
                }
                .frame(height: 250)
                
                Button(action: {
                    viewModel.register()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue)
                        Text("Sign In")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
                .frame(width: 200, height: 50)
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Do you have an account?")
                            .multilineTextAlignment(.trailing)
                        
                        NavigationLink("Login") {
                            LoginView()
                        }
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    LoginView()
}

