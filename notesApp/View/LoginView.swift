import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage).foregroundStyle(.red)
                    }

                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .frame(height: 180)
                .scrollContentBackground(.hidden)
                Button(action: {
                    viewModel.login()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue)
                        Text("Log In")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
                .frame(width: 200, height: 50)
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Don't you have an account?")
                            .multilineTextAlignment(.trailing)
                        
                        NavigationLink("Create An Account") {
                            RegisterView()
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

