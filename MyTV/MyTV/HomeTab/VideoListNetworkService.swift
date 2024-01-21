//
//  VideoListNetworkService.swift
//  MyTV
//
//  Created by Rahul Anand on 19/01/24.
//

import Foundation

enum VideoError: Error {
    case unknown
    case invalidResponse
    case timeout
    case dataNotFound
}

final class VideoListNetworkService {
    
    static func fetchVideoList(endpoint: URL, completion: @escaping ([VideoDetails]?, Error?) -> Void) {
        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: endpoint) { data, response, error in
            if let _ = error {
                completion(nil, VideoError.invalidResponse)
            } else {
                if let data = data {
                    let videoDetails = try? decoder.decode([VideoDetails].self, from: data)
                    completion(videoDetails, nil)
                } else {
                    completion(nil, VideoError.dataNotFound)
                }
            }
        }.resume()
        
    }
}
