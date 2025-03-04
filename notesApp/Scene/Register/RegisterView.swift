import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                VStack {
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage).foregroundStyle(.red)
                    }
                     TextField("Name", text: $viewModel.name)
                         .autocorrectionDisabled(true)
                         .textInputAutocapitalization(.none)
                         .padding()
                         .overlay(
                             RoundedRectangle(cornerRadius: 5)
                                 .stroke(Color.gray, lineWidth: 1)
                         )
                    TextField("Surname", text: $viewModel.surname)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    TextField("Email", text: $viewModel.email )
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    SecureField("Password", text: $viewModel.password )
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .frame(height: 250)
                .padding(.all, 30)
                Button(action: {
                    viewModel.register()
                }, label: {
                Text("Sign Up")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                    
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
    RegisterView(viewModel: RegisterViewViewModel())
}
