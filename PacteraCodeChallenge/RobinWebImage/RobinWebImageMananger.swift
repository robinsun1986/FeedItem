//
//  RobinWebImageMananger.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 12/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation
import UIKit

let ROBIN_WEB_IMAGE_CACHES_DIRECTORY_NAME = "RobinWebImageCaches"

enum LoadImageError: Error {
    case emptyImage
}

class RobinWebImageManager {
    static let shared = RobinWebImageManager()
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    private let loadImageQueue = OperationQueue()
    
    var canDownload: Bool = true
    
    private init() {}
    
    func getCachedImage(url: URL) -> UIImage? {
        var cachedImage = getMemoryCachedImage(forKey: url.absoluteString)
        
        if (cachedImage == nil) {
            cachedImage = getDiskCachedImage(forKey: url.absoluteString)
            
            if let cachedImage = cachedImage {
                saveToMemoryCache(image: cachedImage, url: url)
//                print("getDiskCachedImage")
            }
            
        } else {
//            print("getMemoryCachedImage")
        }
        
        return cachedImage
    }
    
    func downloadImage(url: URL, successHandler: (UIImage) -> (), errorHandler: (Error) -> ()) {
        guard self.canDownload else {
            self.canDownload = true
            return
        }
        
        do {
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data: imageData)
            
            if let image = image {
//                print("downloadImage")
                saveToMemoryCache(image: image, url: url)
                saveToDiskCache(data: imageData, url: url)
                successHandler(image)
            } else {
                errorHandler(LoadImageError.emptyImage)
            }
            
        } catch {
            errorHandler(error)
        }
    }
    
    func addLoadImageOperation(operation: Operation) {
        loadImageQueue.addOperation(operation)
    }
    
    func clearMemoryCache() {
        imageCache.removeAllObjects()
    }
    
    func clearDiskCache() {
        do {
            try FileManager.default.removeItem(at: getCacheDirectory())
        }
        catch {

        }
    }
    
    private func saveToMemoryCache(image: UIImage, url: URL) {
        imageCache.setObject(image as AnyObject, forKey: url.absoluteString as AnyObject)
    }
    
    private func saveToDiskCache(data: Data, url: URL) {
        var writePath = getCacheDirectory()
        
        if !FileManager.default.fileExists(atPath: writePath.path) {
            do {
                try FileManager.default.createDirectory(at: writePath, withIntermediateDirectories: false, attributes: nil)
            } catch {
                //print("\(error.localizedDescription)")
            }
        }
        
        let fileName = processedFileName(forUrlString: url.absoluteString)
        writePath.appendPathComponent(fileName, isDirectory: false)
        do {
//            print("\(writePath.path)");
            try data.write(to: writePath)
        } catch {
            //print("\(error.localizedDescription)")
        }
    }
    
    private func processedFileName(forUrlString urlString: String) -> String {
        let doNotWant = CharacterSet(charactersIn: ":/.")
        let processedFileName = urlString.components(separatedBy: doNotWant).joined(separator: " ")
        return processedFileName
    }
    
    private func getMemoryCachedImage(forKey key: String?) -> UIImage? {
        var image: UIImage?
        
        if let key = key {
            image = imageCache.object(forKey: key as AnyObject) as? UIImage
        }

        return image
    }
    
    private func getDiskCachedImage(forKey key: String?) -> UIImage? {
        var image: UIImage?
        if let key = key {
            var path = getCacheDirectory()
            let fileName = processedFileName(forUrlString: key)
            path.appendPathComponent(fileName, isDirectory: false)
            do {
                let data = try Data(contentsOf: path)
                image = UIImage(data: data)
            } catch {
                
            }
        }
        
        return image
    }
    
    private func getCacheDirectory() -> URL {
        var url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        url.appendPathComponent(ROBIN_WEB_IMAGE_CACHES_DIRECTORY_NAME, isDirectory: true)
        return url
    }
}





