import Foundation
import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    
    private init() { }
    
    func setImage(coinImage: UIImage, imageName: String, folderName: String) {
        // MARK: Create folder
        createFolder(folderName: folderName)
        
        // MARK: Get path for image
        guard
            let data = coinImage.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName) else {
            return
        }
        
        // MARK: Save Image
        do {
            try data.write(to: url)
        } catch let error {
            print("DEBUG: ERROR SAVING IMAGE, IMAGE NAME:\(imageName). \(error.localizedDescription)")
        }
    }
    
    func fetchImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolder(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("DEBUG: ERROR CREATING FOLDER, FOLDER NAME:\(folderName). \(error.localizedDescription)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
}
