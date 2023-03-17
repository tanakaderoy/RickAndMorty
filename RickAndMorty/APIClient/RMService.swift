//
//  RMService.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/11/23.
//

import Foundation

/// Primary API service for rick and morty service
final class RMService {
    /// Singleton instance of RMService
    static let shared = RMService()
    
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(_ rmRequest: RMRequest, expecting: T.Type) async -> Result<T,Error> {
        do {
            guard let urlRequest = request(from: rmRequest) else { return .failure(RMServiceError.failedToCreateRequest)}
            let (data,_) = try await URLSession.shared.data(for: urlRequest)
            let result = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        }catch (let error){
            return .failure(error)
        }
    }
    
    
    // MARK: - Private
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else {return nil}
        
        var request =  URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
}


extension RMService {
    static func getAllCharacters() async -> Result<([RMCharacter],RMGetAllCharactersResponse.Info),Error> {
        let result = await RMService.shared.execute(RMRequest.listCharactersRequest, expecting: RMGetAllCharactersResponse.self)
        switch result {
    case .success(let response):
            return .success((response.results, response.info))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func getPagenatedCharacters(urlString:String) async -> Result<([RMCharacter],RMGetAllCharactersResponse.Info), Error> {
        guard let url = URLComponents(string: urlString) else {return .failure(NSError(domain: "No URL", code: 0))}
        guard let pageValue = url.queryItems?.first(where: {$0.name == "page"})?.value else {return .failure(NSError(domain: "No query param", code: 1))}
        
        let request = RMRequest(endpoint: .character, queryParameters: [URLQueryItem(name: "page", value: pageValue)])
        let result = await RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self)
        switch result {
        case .success(let response):
            return .success((response.results,response.info))
        case .failure(let error):
            return .failure(error)
        }
    }
}
