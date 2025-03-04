import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                VStack {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage).foregroundStyle(.red)
                    }
                    
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .frame(height: 180)
                .scrollContentBackground(.hidden)
                .padding(.all, 30)
                Button(action: {
                    viewModel.login()
                }, label: {
                    ZStack {
                        Text("Log In")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                    }
                })
                .frame(width: 200, height: 50)
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Don't you have an account?")
                            .multilineTextAlignment(.trailing)
                        
                        NavigationLink("Create An Account") {
                            RegisterView(viewModel: RegisterViewViewModel())

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

