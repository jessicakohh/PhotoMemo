//
//  UserService.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/27.
//

import Firebase

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)


// 유저 데이터를 다루는 함수
struct UserService {
    
    static let shared = UserService()
    
    func updateProfileImage(image: UIImage, completion: @escaping(URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let filename = NSUUID().uuidString
        let ref = storageProfileImages.child(filename)
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {
                    completion(nil)
                    return
                }
                let values = ["profileImageUrl": profileImageUrl]
                
                refUsers.child(uid).updateChildValues(values) { (err, ref) in
                    completion(url)
                    
                }
            }
        }
    }
    
    func updateUsername(_ username: String, completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["username": username]
        
        refUsers.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
    

    
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
