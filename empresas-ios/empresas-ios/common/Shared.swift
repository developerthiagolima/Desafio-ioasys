//
//  Shared.swift
//  empresas-ios
//
//  Created by Thiago Lima on 24/10/20.
//  Copyright © 2020 ioasys. All rights reserved.
//

import UIKit
import SDWebImage

func carregarImagem(imageView: UIImageView, fileName: String, pathUrl: String) {
    if let local = loadImage(fileName) {
        imageView.image = local
    } else {
        imageView.image = UIImage()
        let url = API.baseUrl + pathUrl
        SDWebImageDownloader.shared.downloadImage(with: URL(string: url),
                                                  options: .continueInBackground,
                                                  progress: nil,
                                                  completed: { (image, data, error, bool) -> Void in
                                                    if image != nil {
                                                        saveImage(image!, fileName: fileName)
                                                        imageView.image = image
                                                    }
        })
    }
}

func carregarImagem(fileName: String, url: String, completion:@escaping (UIImage) -> ()) {
    if let local = loadImage(fileName) {
        completion(local)
    } else {
        SDWebImageDownloader.shared.downloadImage(with: URL(string: url),
                                                    options: .continueInBackground,
                                                    progress: nil,
                                                    completed: { (image, data, error, bool) -> Void in
                                                        if image != nil {
                                                            saveImage(image!, fileName: fileName)
                                                            completion(image!)
                                                        }
        })
    }
}

private func saveImage(_ imagem: UIImage, fileName: String){
    var fullNameArr = fileName.components(separatedBy: ".")
    fullNameArr[1] = fullNameArr[1].lowercased()
    if fullNameArr[1] == "png" {
        let imageData: NSData = imagem.pngData()! as NSData
        FileManager.default.createFile(atPath: String(format: "%@/%@", arguments: [documentsDirectoryPath(),fileName]), contents: imageData as Data, attributes: nil)
    }else {
        let imageData: NSData = imagem.jpegData(compressionQuality: 1.0)! as NSData
        FileManager.default.createFile(atPath: String(format: "%@/%@", arguments: [documentsDirectoryPath(),fileName]), contents: imageData as Data, attributes: nil)
    }
}

private func loadImage(_ fileName: String) -> UIImage!{
    if let result = UIImage(contentsOfFile: String(format: "%@/%@", arguments: [documentsDirectoryPath(),fileName])){
        return result
    }else{
        return nil
    }
}

private func documentsDirectoryPath() -> NSString{
    var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    paths = paths.deletingLastPathComponent.stringByAppendingPathComponent(path: "tmp") as NSString
    if(FileManager.default.fileExists(atPath: paths as String)){
        do {
            try FileManager.default.createDirectory(atPath: paths as String, withIntermediateDirectories: false, attributes: nil)
        } catch _ {
        }
    }
    let directoryUrl = NSURL(fileURLWithPath: paths as String, isDirectory: true)
    do {
        try directoryUrl.setResourceValue(NSNumber(value: true), forKey: URLResourceKey.isExcludedFromBackupKey)
    } catch _ {
    }
    
    return paths
}
