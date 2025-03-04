import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var surname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    func register() {
        print("Firebase Başlatıldı mı? \(FirebaseApp.app() != nil)")
        guard validate() else {
            print("Validation failed!")
            return
        }


        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Firebase Auth Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    strongSelf.errorMessage = "Auth Error: \(error.localizedDescription)"
                }
                return
            }

            guard let userId = authResult?.user.uid else {
                print("User ID is nil!")
                DispatchQueue.main.async {
                    strongSelf.errorMessage = "User ID not found"
                }
                return
            }

            print("Kullanıcı oluşturuldu! UID: \(userId)")

            strongSelf.createUserWithFirestore(userId: userId)
        }
    }

    func createUserWithFirestore(userId: String) {
        let db = Firestore.firestore()
        
        let userData: [String: Any] = [
            "userId": userId,
            "name": name.trimmingCharacters(in: .whitespacesAndNewlines),
            "surname": surname.trimmingCharacters(in: .whitespacesAndNewlines),
            "email": email.trimmingCharacters(in: .whitespacesAndNewlines)
        ]
        db.collection("users").document(userId).setData(userData) { [weak self] error in
            if let error = error {
                print("Firestore error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.errorMessage = "Firestore Error: \(error.localizedDescription)"
                }
            } else {
                print("Kullanıcı başarıyla kaydedildi!")
            }
        }
    }

    func validate() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !surname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter all fields."
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Invalid email format."
            return false
        }
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long."
            return false
        }
        return true
    }
}

