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
        
        print("🔥 Firebase Başlatıldı mı? \(FirebaseApp.app() != nil)")
        guard validate() else { return }
        print("Starting user registration...")


        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    strongSelf.errorMessage = "Auth Error: \(error.localizedDescription)"
                }
                return
            }

            guard let userId = authResult?.user.uid else {
                DispatchQueue.main.async {
                    strongSelf.errorMessage = "User ID not found"
                }
                return
            }

            strongSelf.createUserWithFirestore(userId: userId, name: strongSelf.name, surname: strongSelf.surname, email: strongSelf.email)
        }
    }

     func createUserWithFirestore(userId: String, name: String, surname: String, email: String) {
        let newUser = UserModel(userId: userId, name: name, surname: surname, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        let userData = newUser.toFirestoreDictionary()
        
        print("📌 Firestore'a veri yazma işlemi başladı!")
        print("🔥 Kaydedilecek veri: \(userData)")
        
        db.collection("users").document(userId).setData(userData) { [weak self] error in
            print("📌 db.collection işlemi başladı...")
            if let error = error {
                self?.errorMessage = "❌ Firestore Error: \(error.localizedDescription)"
                print("❌ Firestore error: \(error.localizedDescription)")
            } else {
                print("✅ Firestore: Kullanıcı başarıyla kaydedildi!")
            }
        }
    }

    func validate() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !surname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter all fields"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Invalid email"
            return false
        }
        return true
    }
}

