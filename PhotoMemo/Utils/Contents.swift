//
//  Contents.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/26.
//

import Firebase
import FirebaseStorage

// Storage 초기화
let storageRef = Storage.storage().reference()
// STORAGE_REF를 기반으로, 해당 경로에 대한 참조를 생성하여 프로필 이미지를 저장하고 로드하는데에 사용
let storageProfileImages = storageRef.child("profile_images")

// RealtimeDatabase 초기화
let dbRef = Database.database().reference()
// 모든 사용자에 대한 정보를 저장한다.
let refUsers = dbRef.child("users")

