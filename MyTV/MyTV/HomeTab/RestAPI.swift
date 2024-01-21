//
//  RestAPI.swift
//  MyTV
//
//  Created by Rahul Anand on 21/01/24.
//

import Foundation

final class RestAPI {
    
    private var endPoint: String {
        guard let filePath = Bundle.main.path(forResource: "FB-Info", ofType: "plist") else {
            fatalError("Path not found")
        }
        let pList = NSDictionary(contentsOfFile: filePath)
        guard let host = pList?.object(forKey: "HOST") as? String else {
            fatalError("Host not found")
        }
        return host
    }
    
    func getUrlForVideos() -> URL? {
        URL(string: endPoint)
    }
}
