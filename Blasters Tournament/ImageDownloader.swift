//
//  ImageDownloader.swift
//  Blasters Tournament
//
//  Created by Mayank Sharma on 05/02/24.
//

import UIKit
class ImageDownloader {
    static func downloadImage(_ urlString: String, completion: ((UIImage?, String?) -> ())?) {
       guard let url = URL(string: urlString) else {
          completion?(nil, urlString)
          return
      }
      URLSession.shared.dataTask(with: url) { (data, response,error) in
         if let error = error {
            print("error in downloading image: \(error)")
            completion?(nil, urlString)
            return
         }
         guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
            completion?(nil, urlString)
            return
         }
         if let data = data, let image = UIImage(data: data) {
            completion?(image, urlString)
            return
         }
         completion?(nil, urlString)
      }.resume()
   }
}
