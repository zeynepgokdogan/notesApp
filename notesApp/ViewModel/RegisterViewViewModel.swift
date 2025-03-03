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
        guard validate() else {
            print("❌ Validation failed!")
            return
        }

        print("🚀 Kullanıcı kaydı başlıyor...")

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("❌ Firebase Auth Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    strongSelf.errorMessage = "Auth Error: \(error.localizedDescription)"
                }
                return
            }

            guard let userId = authResult?.user.uid else {
                print("❌ User ID is nil!")
                DispatchQueue.main.async {
                    strongSelf.errorMessage = "User ID not found"
                }
                return
            }

            print("✅ Kullanıcı oluşturuldu! UID: \(userId)")

            strongSelf.createUserWithFirestore(userId: userId)
        }
    }

    func createUserWithFirestore(userId: String) {
        print("⚡ Firestore'a veri yazma fonksiyonu çağrıldı!")

        let db = Firestore.firestore()
        
        let userData: [String: Any] = [
            "userId": userId,
            "name": name.trimmingCharacters(in: .whitespacesAndNewlines),
            "surname": surname.trimmingCharacters(in: .whitespacesAndNewlines),
            "email": email.trimmingCharacters(in: .whitespacesAndNewlines)
        ]
        
        print("📌 Firestore'a kaydedilecek veri: \(userData)")

        db.collection("users").document(userId).setData(userData) { [weak self] error in
            print("📌 Firestore’a yazma işlemi başladı...")

            if let error = error {
                print("❌ Firestore error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.errorMessage = "❌ Firestore Error: \(error.localizedDescription)"
                }
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
            errorMessage = "Lütfen tüm alanları doldurun."
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Geçersiz e-posta adresi."
            return false
        }
        guard password.count >= 6 else {
            errorMessage = "Şifre en az 6 karakter olmalıdır."
            return false
        }
        return true
    }
}

