//
//  NetworkCore.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 21.03.2024.
//

import Foundation

protocol Responsable: Decodable {
}

enum NetworkError: Error {
    case invalidURL
//    case responseDecodingError
}

protocol NetworkCoreProtocol {
    func request<Res: Responsable>(metadata: String, completion: @escaping (Result<Res, Error>) -> Void)
}

final class NetworkCore {
    static let shared: NetworkCoreProtocol = NetworkCore()
    
    private let key = "aabf3d2a8a21d3ce96239161108b71db"
    private let urlString = "https://api.openweathermap.org/data/2.5/weather?"
    private let jsonDecoder = JSONDecoder()
}

// https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

extension NetworkCore: NetworkCoreProtocol {
    
    func request<Res: Responsable>(metadata: String, completion: @escaping (Result<Res, Error>) -> Void) {
        let urlRequest = URL(string: "\(urlString)\(metadata)&appid=\(key)")
        
        print("\(urlString)\(metadata)&appid=\(key)")
    
        guard let url = urlRequest else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let dataTask = URLSession
            .shared
            .dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data,
                   (response as? HTTPURLResponse)?.statusCode == 200,
                   error == nil {
                    self.handleSuccsesDataResponse(data, completion: completion)
                }
            })
        dataTask.resume()
    }
}

extension NetworkCore {
    private func handleSuccsesDataResponse<Res: Responsable>(_ data: Data, completion: (Result<Res, Error>) -> Void) {
        do {
            completion(.success(try decodeData(data: data)))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func decodeData<Res: Responsable>(data: Data) throws -> Res {
        let response = try jsonDecoder.decode(Res.self, from: data)
        return response
    }
}
