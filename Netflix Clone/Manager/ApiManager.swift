//
//  ApiManager.swift
//  Netflix Clone
//
//  Created by HAMZA on 14/6/2022.
//

import Foundation

struct Constants {
    static let API_Key = "61168c91425a4f4e1ce4057a1255635b"
    static let basicURL = "https://api.themoviedb.org"
}

enum ApiError: Error {
    case failedToGetData
}

class ApiManager {
    static let shared = ApiManager()
    
    
    
    func getTrendingMovies(completion: @escaping (Result<[MovieTv], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.basicURL)/3/trending/movie/day?api_key=\(Constants.API_Key)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesTv.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    func getTrendingTvs(completion: @escaping (Result<[MovieTv], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.basicURL)/3/trending/tv/day?api_key=\(Constants.API_Key)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesTv.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(ApiError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getUpcoming(completion: @escaping (Result<[MovieTv], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/movie/upcoming?api_key=\(Constants.API_Key)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesTv.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(ApiError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[MovieTv], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/movie/popular?api_key=\(Constants.API_Key)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                
                let results = try JSONDecoder().decode(TrendingMoviesTv.self, from: data)
                completion(.success(results.results))
            } catch {
                
                completion(.failure(ApiError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[MovieTv], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basicURL)/3/movie/top_rated?api_key=\(Constants.API_Key)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesTv.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(ApiError.failedToGetData))

            }
        }
        task.resume()
    }
    
}



