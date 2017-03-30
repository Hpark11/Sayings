
import UIKit

let imageCache: NSCache<NSString, UIImage> = NSCache()

class DownloadImageView : UIImageView {
    
    var imageUrlString: String? {
        didSet {
            if let imageUrlString = imageUrlString {
                loadImageUsingUrlString(urlString: imageUrlString)
            }
        }
    }
    
    func loadImageUsingUrlString(urlString: String) {
        let url: URL? = URL(string: urlString)
        image = nil
        
        if let url = url {
            if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
                self.image = imageFromCache
                return
            }
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print(error as Any)
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    let imageToCache = UIImage(data: data!)
                    self.image = imageToCache
                    imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                })
            }).resume()
        }
    }
}
