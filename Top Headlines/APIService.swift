//
//  APIService.swift
//  Top Headlines
//
//  Created by GeoSpark on 05/08/21.
//

import Foundation

class APIService {
    static let shared = APIService()
    enum APIError: Error {
        case error(_ errorString: String)
    }
    
    func getJSON<T: Decodable>(urlString: String,
                               dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                               keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                               completion: @escaping (Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
                return
            }
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data us corrupt.", comment: ""))))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                return
            }
        }.resume()
    }
    
    @available(iOS 15,*)
    @MainActor
    func getJSON<T: Decodable>(urlString: String,
                               dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                               keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws ->T{
        guard let url = URL(string: urlString) else {
            throw
            APIError.error(NSLocalizedString("Error: Invalid URL", comment: ""))
        }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let _ = response as? HTTPURLResponse else {
            throw APIError.error(NSLocalizedString("Error: Data Request error ", comment: ""))
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

    
        guard let decodeData  = try? decoder.decode(T.self, from: data) else{
            throw APIError.error(NSLocalizedString("Error: Data Request error ", comment: ""))
        }
        return decodeData
 
    }

    
}
