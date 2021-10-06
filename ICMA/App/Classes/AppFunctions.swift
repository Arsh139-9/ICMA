//
//  AppFunctions.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import Foundation
import UIKit
import AssistantKit
import Toucan
import CoreLocation

/// This function will retutn font size according to device.
///
/// - Parameter fontDefaultSize: <#fontDefaultSize description#>
/// - Returns: <#return value description#>
func getDynamicFontSize(fontDefaultSize: CGFloat ) -> CGFloat {
    
    var fontSize : CGFloat = 0.0
    let device = Device.version
    
    if device == Version.phone4 || device == Version.phone5 {
        fontSize = fontDefaultSize
    } else if device == Version.phone6 || device == Version.phone7 || device == Version.phone6S || device == Version.phone8 {
        fontSize = fontDefaultSize
    } else if device == Version.phone7Plus || device == Version.phone8Plus {
        fontSize = fontDefaultSize + ICFont.increaseSize
    } else if device == Version.phoneX || device == Version.phoneXR || device == Version.phoneXS || device == Version.phoneXSMax {
        fontSize = fontDefaultSize + ICFont.increaseSize
    } else
    //7.9 inches
    if device == Version.padMini || device == Version.padMini2 || device == Version.padMini3 || device == Version.padMini4 {
        fontSize = fontDefaultSize - ICFont.reduceSize
        //9.7 inches
    } else if device == Version.padAir || device == Version.padAir2  || device == Version.pad1 || device == Version.pad2 || device == Version.pad3 || device == Version.pad4 {
        //fontSize = fontDefaultSize + PMFont.increaseSize
        fontSize = fontDefaultSize
        //10.5 and later
    } else if device == Version.padPro {
        fontSize = fontDefaultSize + ICFont.increaseSize
    } else {
        fontSize = fontDefaultSize
    }
    
    return fontSize
}

/// Delay in execuation of statement
/// - Parameters:
///   - delay: <#delay description#>
///   - closure: <#closure description#>
func delay(_ delay: Double = 0.3, closure:@escaping ()->()) {
    DispatchQueue.main.async {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}

func delayInLoading(_ delay: Double = 1, closure:@escaping ()->()) {
    DispatchQueue.main.async {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}

//func getPlaceholderImage() -> UIImage? {
//    return Toucan.init(image: UIImage(named: "")!).resizeByCropping(SSSettings.).maskWithRoundedRect(cornerRadius: FGSettings.profileImageSize.width/2, borderWidth: FGSettings.profileBorderWidth, borderColor: FGColor.appGreen).image
//}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


func getEmptyView() -> UIView {
    let view = UIView(frame: CGRect.zero)
    view.backgroundColor = UIColor.clear
    return view
}

func localized(code: Int) -> String {
    
    let codeKey = String(format: "error_%d", code)
    let localizedMessage = codeKey.localized()
    return localizedMessage
}


func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}
//func localized(code: Int) -> String {
//
//    let codeKey = String(format: "error_%d", code)
//    let localizedMessage = codeKey.localized()
//    return localizedMessage
//}


extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 80, y: 200, width: 290, height: 70))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Roboto-Medium", size: 20)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

func getDistanceInKm(from coordinate0: CLLocationCoordinate2D?, coordinate1: CLLocationCoordinate2D?) -> String {
    let location1 = CLLocation(latitude: coordinate0?.latitude ?? .zero, longitude: coordinate0?.latitude ?? .zero)
    let location2 = CLLocation(latitude: coordinate1?.latitude ?? .zero, longitude: coordinate1?.latitude ?? .zero)
    let distance = location1.distance(from: location2)
    let km = Measurement(value: distance, unit: UnitLength.meters).converted(to: UnitLength.miles)
    let formatter = MeasurementFormatter()
    formatter.unitOptions = .providedUnit
    formatter.unitStyle = .short
    return formatter.string(from: km)
}

func stringToDate(string: String, dateFormat: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.date(from: string)
}

extension Collection {
    public func chunk(n: IndexDistance) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}

extension String {
    func chunkFormatted(withChunkSize chunkSize: Int = 4,
                        withSeparator separator: Character = "-") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize)
            .map{ String($0) }.joined(separator: String(separator))
    }
    var trimWhiteSpace: String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var htmlStripped : String{
        let tagFree = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return tagFree.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}


