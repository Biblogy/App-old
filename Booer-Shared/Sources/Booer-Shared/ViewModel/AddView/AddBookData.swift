//
//  File.swift
//  
//
//  Created by Veit Progl on 07.05.21.
//

import Foundation
import SwiftUI
import Combine
import CoreData
#if !os(iOS)
import AppKit
#endif
import CoreGraphics

public class AddBookData: ObservableObject {
    public init () {}
    
    @Published public var title = ""
    @Published public var progress: Float = 0
    @Published public var author = ""
    @Published public var isbn = "000"
    @Published public var baugtAt = Date()
    @Published public var id = UUID().uuidString
    #if os(iOS)
    @Published public var image: UIImage?
    #else
    @Published public var image: NSImage?
    
    func pngDataFrom(image:NSImage) -> Data {
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.png, properties: [:])!
        return jpegData
    }
    
    func nsImageFrom(data: Data) -> NSImage {
        
        return NSImage(data: data)!
    }
    #endif
    
    @Published public var state: BookProgressState = .bookshelf
    @Published public var pages = "" {
        didSet {
            let filtered = pages.filter { $0.isNumber }
            
            if pages != filtered {
                pages = filtered
            }
        }
    }
    
    private func generateThundnailImage() -> UIImage {
        if #available(iOS 15.0, *) {
            return (image?.preparingThumbnail(of: CGSize(width: 720, height: 1080)))!
        } else {
            // Fallback on earlier versions
            return image!
        }
    }
    
    public func saveToDB(context: NSManagedObjectContext) -> Bool {
        if self.title != "" && self.pages != "" {
            let newItem = Book(context: context)
            newItem.title = self.title
            newItem.progress = self.progress
            newItem.author = self.author
            newItem.isbn = self.isbn
            newItem.coverColor = Color(self.image?.averageColor ?? UIColor.gray)
            #if os(iOS)
            newItem.cover = image?.pngData()
            newItem.thumbnail = generateThundnailImage().pngData()
            #else
            newItem.cover = pngDataFrom(image: image!)
            #endif
            newItem.year = self.baugtAt
            newItem.state = .bookshelf
            newItem.id = self.id
            newItem.pages = Float(self.pages) ?? 0
            newItem.state = state

            do {
                try context.save()
                return true
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        } else {
//            isCorrect = false
            return false
        }
    }
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
