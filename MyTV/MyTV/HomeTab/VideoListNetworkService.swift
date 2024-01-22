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

protocol VideoListNetworkServiceProtocol {
    typealias CompletionHandler = ([VideoDetails]?, Error?) -> Void

    func fetchVideoList(endpoint: URL, completion: @escaping CompletionHandler)
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

final class VideoListNetworkService: VideoListNetworkServiceProtocol {
    
    static var shared: VideoListNetworkServiceProtocol = VideoListNetworkService()

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchVideoList(endpoint: URL, completion: @escaping CompletionHandler) {
        let decoder = JSONDecoder()
        session.dataTask(with: endpoint) { data, response, error in
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

extension URLSession: URLSessionProtocol {
    
}
