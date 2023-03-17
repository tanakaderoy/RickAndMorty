//
//  RMImageManager.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/18/23.
//

import UIKit
import Foundation

final class RMImageManager{
    public static let shared: RMImageManager = RMImageManager()
    
    private init(){}
    
    private var imageCache: NSCache = NSCache<NSString, NSData>()
    static var cache: [URL:Data] = [:]
    
    public func fetchImage(url: URL?) async -> UIImage? {
        guard let url = url else {return nil}
        let urlNSString = url.absoluteString as NSString
        if let data = imageCache.object(forKey: urlNSString) {
            let imageData = data as Data
            let image = UIImage(data: imageData)
            print("From Cache: \(url.absoluteString)")
            return image
        }else{
            do{
                let (data,_) = try await URLSession.shared.data(from: url)
                imageCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                return UIImage(data: data)
            }catch (let error){
                print("Image failed to load")
                print(error)
                return nil
            }
        }
    }
}
