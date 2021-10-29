//
//  NetworkManager.swift
//  VKClient
//
//  Created by Ilya on 29.10.2021.
//

import Foundation
import Alamofire

protocol AnyNetworkSerivce {
    func getFriends(userId: Int, completion: @escaping ((Result<[FriendItem], Error>) -> Void))
}

class NetworkSerivce: AnyNetworkSerivce {
    
    private let baseURL = "https://api.vk.com/method/"
    private let versionVKAPI = "5.130"
    
    private enum Paths: String {
        case getPhotos = "photos.get"
        case getAlbums = "photos.getAlbums"
        case getUserPhotos = "photos.getUserPhotos"
        case getFriends = "friends.get"
    }
    
    //получение списка друзей по ID
    func getFriends(userId: Int, completion: @escaping ((Result<[FriendItem], Error>) -> Void)) {
        
        guard let token = UserDefaults.standard.string(forKey: "vkToken") else { return }
        
        let url = baseURL + Paths.getFriends.rawValue
        let count = 500
        let offset = 0
        let fields = "sex, bdate, city, photo_100"
        
        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "user_id": userId,
            "count": count,
            "offset": offset,
            "fields": fields,
        ]
        
        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        var friends = try JSONDecoder().decode(Friends.self, from: data).response.items
                        
                        friends = friends.filter {
                            $0.deactivated == nil
                        }
                        
                        completion(.success(friends))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    ///получение фотографий человека
    func getPhotos(ownerId: Int = UserDefaults.standard.integer(forKey: "userId"), albumId: Int, rev: TypeRev = .antiСhronological, completion: @escaping ((Result<[PhotoItem], Error>) -> Void)) {
        
        guard let token = UserDefaults.standard.string(forKey: "vkToken") else { return }
        
        let url = baseURL + Paths.getPhotos.rawValue
        
        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "owner_id": ownerId,
            "album_id": albumId,
            "extended": "1",
            "rev": rev.rawValue,
        ]
        
        
        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let photos = try JSONDecoder().decode(Photos.self, from: data).response.items
                        completion(.success(photos))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    ///возвращает список фотографий, на которых отмечен пользователь
    func getUserPhotos(ownerId: Int, rev: TypeRev = .antiСhronological, completion: @escaping ((Result<[PhotoItem], Error>) -> Void)) {
        
        guard let token = UserDefaults.standard.string(forKey: "vkToken") else { return }

        let url = baseURL + Paths.getUserPhotos.rawValue

        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "user_id": ownerId,
            "extended": "1",
            "rev": rev.rawValue,
        ]

        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let photos = try JSONDecoder().decode(Photos.self, from: data).response.items
                        completion(.success(photos))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }


    ///получение списка альбомов по ID юзера
    func getAlbums(userId: Int, completion: @escaping ((Result<[AlbumItem], Error>) -> Void)) {
        
        guard let token = UserDefaults.standard.string(forKey: "vkToken") else { return }

        let url = baseURL + Paths.getAlbums.rawValue

        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "need_system": "1",
            "user_id": userId,
        ]

        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let albums = try JSONDecoder().decode(Albums.self, from: data).response.items
                        completion(.success(albums))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
