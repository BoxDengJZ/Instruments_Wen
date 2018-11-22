//
//  AsyncImageView.swift
//  Catstagram
//
//  Created by dengjiangzhou on 2018/5/16.
//  Copyright © 2018年 Luke Parham. All rights reserved.
//

// 异步解码图片视图

import UIKit

class AsyncImageView: UIView {

    // So the first thing you wanna do
    // is to make this imageView class able to accept an image,
    private var _image : UIImage?           // 感觉 这个 就是一个 障眼法, place holder
    
    var image: UIImage?{
        get {
            return _image
        }       //   get
        set{
            _image = newValue
            layer.contents = nil
            guard let image = newValue else {       return            }
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated ).async{
                let decodedImage = self.decodeImage(image)
                DispatchQueue.main.async {
                    self.layer.contents = decodedImage?.cgImage
                }
            }
        }
        
    }
    
    
    
    
    func decodeImage(_ image: UIImage) -> UIImage?{
        guard let newImage = image.cgImage else {
            return nil
        }       // first , we will grab our CG image from the past UIImage
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: newImage.width, height: newImage.height, bitsPerComponent: 8, bytesPerRow: newImage.width * 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(newImage, in: CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height))
         // create a graphics context, which we will render this image into .
        // render into the context
        
        
        let decodedImage = context?.makeImage()
        
        if let decodedImage = decodedImage{
            return UIImage(cgImage: decodedImage)   // successfully got an image. we return it.
        }
        return nil
    }

}
