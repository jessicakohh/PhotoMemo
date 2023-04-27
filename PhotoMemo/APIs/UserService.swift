//
//  UserService.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/27.
//

import Firebase

struct UserService {
    
    static let shared = UserService()

    func fetchUser(completion: @escaping (UserModel) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        refUsers.child(uid).observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                let username = data["username"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let uid = data["uid"] as? String ?? ""
                let imageUrl = data["profileImageUrl"] as? String // 수정된 코드
                print("imageUrl: ", imageUrl) // 프로필 이미지 URL 출력

                let userModel = UserModel(username: username, email: email, uid: uid, profileImageUrl: imageUrl)

                completion(userModel)
            }
        }
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to download image: \(error?.localizedDescription ?? "")")
                completion(nil)
                return
            }

            if let image = UIImage(data: data) {
                print("Downloaded image successfully")
                completion(image)
            } else {
                print("Failed to create image from data")
                completion(nil)
            }
        }

        task.resume()
    }

}
