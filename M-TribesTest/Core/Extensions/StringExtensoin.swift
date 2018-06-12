//
//  StringExtensoin.swift
//  Twigano
//
//  Created by mac on 8/2/17.
//  Copyright © 2017  islam elshazly. All rights reserved.
//

import UIKit

extension String {

    
    func isGif() -> Bool{
        let gif = String(self.suffix(3))
        return gif.lowercased() == "gif"

    }
    
    func underlinedAttributedString() -> NSAttributedString? {
        
        return NSAttributedString(string: self, attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        
        
    }
    
    func removeSpaces() -> String? {
        return self.replacingOccurrences(of: "{0}", with: "")
    }
    
    func formatLocalizedString(withValue newValue: String) -> String{
        return self.replacingOccurrences(of: "{0}", with: newValue)
    }
    
    func formatLocalizedString(firstValue firstStr: String, secondValue secondStr: String) -> String {
        var formattedString = self.replacingOccurrences(of: "{0}", with: firstStr)
        formattedString = formattedString.replacingOccurrences(of: "{1}", with: secondStr)
        return formattedString
    }
    ///
    
    /// Calculates string width based on max height and font
    ///
    /// - Parameters:
    ///   - height: max height
    ///   - font: font used
    /// - Returns: text width
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.width
    }
    
    
    /// Calculates string height based on max width and font
    ///
    /// - Parameters:
    ///   - width: max width
    ///   - font: font uesd
    /// - Returns: text hight
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }

    func getFullDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxx"
        let dateObject = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        if dateObject != nil {
            let date = dateFormatter.string(from: dateObject!)
            return date
        } else {
            return " "
        }
    }
    
    func formattedDate(with format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxx"
        let dateObject = dateFormatter.date(from: self)
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        if dateObject != nil {
            let date = dateFormatter.string(from: dateObject!)
            return date
        } else {
            return " "
        }
    }
    
    

    
    
    func multipleFontString(withUniqueText unique: String, uiniqueFont uniqueFont: UIFont, andNormalFont normalFont: UIFont) -> NSAttributedString {
        let string = NSString(string: self)
        let differentRange = string.range(of: unique)
        if differentRange.location != NSNotFound {
            let allAttr = [NSAttributedStringKey.font: normalFont]
            let vodafoneAttr = [NSAttributedStringKey.font: uniqueFont]
            
            let attributedText = NSMutableAttributedString(string: self, attributes: allAttr)
            attributedText.addAttributes(vodafoneAttr, range: differentRange)
            
            return attributedText
        }
        return NSAttributedString()
    }
    

  
  //: ### Base64 encoding a string
  func fromBase64() -> String? {
    guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
      return nil
    }
    
    return String(data: data, encoding: .utf8)
  }
  
  //: ### Base64 decoding a string
  func toBase64() -> String {
    return Data(self.utf8).base64EncodedString()
  }
    
    func validatePhoneNumber() -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
    func isValidateYoutubeURL() -> Bool {
        
        return (self.contains("youtube.com") || self.contains("youtu.be")) && self.contains("https://")
    }
    
    
    func isURL () -> Bool {
        
            if let url  = NSURL(string: self) {
                return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    

    func deCodeImage () -> UIImage? {
        if let decodedData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
            return image
        }
        
        return nil
    }
    
    func addStrik()  -> NSMutableAttributedString {

        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
        

    }

    
     func isOnlyEnglishNumber() -> Bool {
        
        let aSet = CharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = self.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return self == numberFiltered
        
    }
}
