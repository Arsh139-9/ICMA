////
////  RestManager.swift
////  RestManager
////
////  Created by Gabriel Theodoropoulos.
////  Copyright © 2019 Appcoda. All rights reserved.
////
//
import Foundation
import UIKit
import SVProgressHUD
import Alamofire

class RestManager {
    
    // MARK: - Properties
    
    var requestHttpHeaders = RestEntity()
    
    var urlQueryParameters = RestEntity()
    
    var httpBodyParameters = RestEntity()
    
    var httpBody: Data?
    
    
    // MARK: - Public Methods
    
    func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HttpMethod,
                     completion: @escaping (_ result: Results) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let targetURL = self?.addURLQueryParameters(toURL: url)
            let httpBody = self?.getHttpBody()
            
            guard let request = self?.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod) else
            {
                completion(Results(withError: CustomError.failedToCreateRequest))
                return
            }
            
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: request) { (data, response, error) in
                completion(Results(withData: data,
                                   response: Response(fromURLResponse: response),
                                   error: error))
            }
            task.resume()
        }
    }
    
    func multiPartFormDataApi(param:[AnyHashable:Any],fileName:String, imgData:Data?,url:URL?,mimeType:String,responseHandler:(([String:AnyObject]) -> Void)!){
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let boundary = generateBoundaryString()
        //define the multipart request type
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let body = NSMutableData()
        
        let fname = fileName
        let mimetype = mimeType
        
        //define the data post parameter
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        
        if let songRawData = imgData
        {
            body.append("Content-Disposition:form-data; name=\"song\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
            body.append(songRawData)
        }
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        for (key, value) in param
        {
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
        }
        
        request.httpBody = body as Data
        
        // return body as Data
        print("Fire....")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (
                data, response, error) in
            print("Complete")
            if error != nil
            {
                print("error upload : \(String(describing: error))")
                responseHandler([:])
                return
            }
            
            do
            {
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                {
                    responseHandler(json as? [String:AnyObject] ?? [:])
                }else
                {
                    print("Invalid Json")
                }
            }
            catch
            {
                print("Some Error")
                responseHandler([:])
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    func sendFile(
        urlPath:String,
        fileName:String,
        data:Data,
        completionHandler: @escaping (URLResponse?, Data?, Error?) -> Void){
        
        let url = URL(string: urlPath)!
        var request1 = URLRequest(url: url)
        
        request1.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        let fullData = photoDataToFormData(data: data ,boundary:boundary,fileName:fileName)
        
        request1.setValue("multipart/form-data; boundary=" + boundary,
                          forHTTPHeaderField: "Content-Type")
        
        // REQUIRED!
        request1.setValue(String(fullData.count), forHTTPHeaderField: "Content-Length")
        
        request1.httpBody = fullData
        request1.httpShouldHandleCookies = false
        
        let queue:OperationQueue = OperationQueue()
        let task = URLSession.shared.dataTask(with: request1) { (data, response, error) in
        }
        task.resume()
        
        
        //            NSURLConnection.sendAsynchronousRequest(
        //                request1 as URLRequest,
        //                queue: queue,
        //                completionHandler:completionHandler)
    }
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }
    // this is a very verbose version of that function
    // you can shorten it, but i left it as-is for clarity
    // and as an example
    func photoDataToFormData(data:Data,boundary:String,fileName:String) -> Data {
        var fullData = Data()
        
        // 1 - Boundary should start with --
        let lineOne = "--" + boundary + "\r\n"
        fullData.append(lineOne.data(
                            using: String.Encoding.utf8,
                            allowLossyConversion: false)!)
        
        // 2
        let lineTwo = "Content-Disposition: form-data; name=\"image\"; filename=\"" + fileName + "\"\r\n"
        NSLog(lineTwo)
        fullData.append(lineTwo.data(
                            using:                             String.Encoding.utf8,
                            allowLossyConversion: false)!)
        
        // 3
        let lineThree = "Content-Type: image/jpg\r\n\r\n"
        fullData.append(lineThree.data(
                            using: String.Encoding.utf8,
                            allowLossyConversion: false)!)
        
        // 4
        fullData.append(data as Data)
        
        // 5
        let lineFive = "\r\n"
        fullData.append(lineFive.data(
                            using: String.Encoding.utf8,
                            allowLossyConversion: false)!)
        
        // 6 - The end. Notice -- at the start and at the end
        let lineSix = "--" + boundary + "--\r\n"
        fullData.append(lineSix.data(
                            using: String.Encoding.utf8,
                            allowLossyConversion: false)!)
        
        return fullData
    }
    
    func getData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else { completion(nil); return }
                completion(data)
            })
            task.resume()
        }
    }
    
    
    
    // MARK: - Private Methods
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
            var queryItems = [URLQueryItem]()
            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                
                queryItems.append(item)
            }
            
            urlComponents.queryItems = queryItems
            
            guard let updatedURL = urlComponents.url else { return url }
            return updatedURL
        }
        
        return url
    }
    
    
    
    private func getHttpBody() -> Data? {
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") else { return nil }
        
        if contentType.contains("application/json") {
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys])
        } else if contentType.contains("application/x-www-form-urlencoded") {
            let bodyString = httpBodyParameters.allValues().map { "\($0)=\(String(describing: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))" }.joined(separator: "&")
            return bodyString.data(using: .utf8)
        } else {
            return httpBody
        }
    }
    
    
    
    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HttpMethod) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue(value, forHTTPHeaderField: header)
        }
        
        request.httpBody = httpBody
        return request
    }
}


// MARK: - RestManager Custom Types

extension RestManager {
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
    
    
    
    struct RestEntity {
        private var values: [String: String] = [:]
        
        mutating func add(value: String, forKey key: String) {
            values[key] = value
        }
        
        func value(forKey key: String) -> String? {
            return values[key]
        }
        
        func allValues() -> [String: String] {
            return values
        }
        
        func totalItems() -> Int {
            return values.count
        }
    }
    
    
    
    struct Response {
        var response: URLResponse?
        var httpStatusCode: Int = 0
        var headers = RestEntity()
        
        init(fromURLResponse response: URLResponse?) {
            guard let response = response else { return }
            self.response = response
            httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
                for (key, value) in headerFields {
                    headers.add(value: "\(value)", forKey: "\(key)")
                }
            }
        }
    }
    
    
    
    struct Results {
        var data: Data?
        var response: Response?
        var error: Error?
        
        init(withData data: Data?, response: Response?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }
        
        init(withError error: Error) {
            self.error = error
        }
    }
    
    
    
    enum CustomError: Error {
        case failedToCreateRequest
    }
}


// MARK: - Custom Error Description
extension RestManager.CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest: return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        }
    }
}
extension Data {
    private static let mimeTypeSignatures: [UInt8 : String] = [
        0xFF : "image/jpeg",
        0x89 : "image/png",
        0x47 : "image/gif",
        0x49 : "image/tiff",
        0x4D : "image/tiff",
        0x25 : "application/pdf",
        0xD0 : "application/vnd",
        0x46 : "text/plain",
    ]
    
    var mimeType: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? "application/octet-stream"
    }
}
extension String {
    
    
    /// the length of the string
    var length: Int {
        return self.count
    }
    
    /// Get substring, e.g. "ABCDE".substring(index: 2, length: 3) -> "CDE"
    ///
    /// - parameter index:  the start index
    /// - parameter length: the length of the substring
    ///
    /// - returns: the substring
    public func substring(index: Int, length: Int) -> String {
        if self.length <= index {
            return ""
        }
        let leftIndex = self.index(self.startIndex, offsetBy: index)
        if self.length <= index + length {
            return self.substring(from: leftIndex)
        }
        let rightIndex = self.index(self.endIndex, offsetBy: -(self.length - index - length))
        return self.substring(with: leftIndex..<rightIndex)
    }
    
    /// Get substring, e.g. -> "ABCDE".substring(left: 0, right: 2) -> "ABC"
    ///
    /// - parameter left:  the start index
    /// - parameter right: the end index
    ///
    /// - returns: the substring
    public func substring(left: Int, right: Int) -> String {
        if length <= left {
            return ""
        }
        let leftIndex = self.index(self.startIndex, offsetBy: left)
        if length <= right {
            return self.substring(from: leftIndex)
        }
        else {
            let rightIndex = self.index(self.endIndex, offsetBy: -self.length + right + 1)
            return self.substring(with: leftIndex..<rightIndex)
        }
    }
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    
    func removeHTMLTag() -> String {
        let str = self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        let replacedStr  = str.replacingOccurrences(of: "&nbsp;", with: "")
        return replacedStr
        
    }
    
    
    static func random(length:Int)->String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        
        while randomString.utf8.count < length{
            let randomLetter = letters.randomElement()
            randomString += randomLetter?.description ?? ""
        }
        return randomString
    }
    var isBlankByTrimming: Bool {
        let trimmed = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    func trimWhitespacesAndNewlines() -> String{
        return self.trimmingCharacters(in:
                                        CharacterSet.whitespacesAndNewlines)
    }
}
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}




