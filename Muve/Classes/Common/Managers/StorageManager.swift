//
//  StorageManager.swift
//  Muve
//
//  Created by Givi Pataridze on 28/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import ObjectMapper
import Firebase

public class StorageManager {
    
    static let sharedManager: StorageManager = {
        return StorageManager()
    }()
    
    let storage: FIRStorage
    let storageRef: FIRStorageReference
    let imagesRef: FIRStorageReference
    var uploadQueue: [FIRStorageUploadTask] = []
    var downloadQueue: [FIRStorageDownloadTask] = []
    
    private init() {
        storage = FIRStorage.storage()
        storageRef = storage.referenceForURL(Firebase.storageUrl)
        imagesRef = storageRef.child("images")
    }
    
    func uploadImage(image: UIImage, completion: (NSURL, String) -> ()) {
        guard let dataImage = UIImagePNGRepresentation(image) else { return }
        let filename = String.randomStringWithLength(10) + ".png"
        let newImagePath = imagesRef.child(filename)
        let _ = newImagePath.putData(dataImage, metadata: nil) { (metadata, error) in
            if let error = error {
                DLog("\(error.localizedDescription)")
            } else if let metadata = metadata {
                if let downloadURL = metadata.downloadURL(), let name = metadata.name {
                    completion(downloadURL, name)
                }
            }
        }
    }
    
    func downloadImage(filename: String, completion: (UIImage) -> ()) {
        let imagePath = imagesRef.child(filename)
        imagePath.dataWithMaxSize(1 * 1024 * 1024) { (data, error) in
            if let error = error {
                DLog("\(error.localizedDescription)")
            } else if let data = data {
                if let image = UIImage(data: data) {
                    completion(image)
                }
            }
        }
    }
}