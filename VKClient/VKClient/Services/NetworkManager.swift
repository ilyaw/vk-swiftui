//
//  NetworkManager.swift
//  VKClient
//
//  Created by Ilya on 29.10.2021.
//

import Foundation
import Alamofire

protocol AnyNetworkSerivce {
    func getFriends(userId: Int, completion: @escaping ((Result<[Friend], Error>) -> Void))
    func getPhotos(ownerId: Int, albumId: Int, completion: @escaping ((Result<[Photo], Error>) -> Void))
    func getUserPhotos(ownerId: Int, completion: @escaping ((Result<[Photo], Error>) -> Void))
    func getAlbums(userId: Int, completion: @escaping ((Result<[Album], Error>) -> Void))
    func getGroups(userId: Int, completion: @escaping ((Result<[Group], Error>) -> Void))
    func getByIdGroups(ids: String, completion: @escaping (Result<[GroupInfo], Error>) -> Void)
    func searchGroups(textSearch: String, completion: @escaping (Result<[Group], Error>) -> Void)
    func joinGroup(groupId: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func leaveGroup(groupId: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class NetworkSerivce: AnyNetworkSerivce {
    
    private let baseURL = "https://api.vk.com/method/"
    private let versionVKAPI = "5.130"
    
    private var token: String {
        UserDefaults.standard.string(forKey: "vkToken") ?? ""
    }
    
    private enum Paths: String {
        case getPhotos = "photos.get"
        case getAlbums = "photos.getAlbums"
        case getUserPhotos = "photos.getUserPhotos"
        case getFriends = "friends.get"
        case getGroups = "groups.get"
        case searchGroups = "groups.search"
        case getByIdGroups = "groups.getById"
        case joinGroup = "groups.join"
        case leaveGroup = "groups.leave"
    }
    
    //получение списка друзей по ID
    func getFriends(userId: Int, completion: @escaping ((Result<[Friend], Error>) -> Void)) {
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
                        var friends = try JSONDecoder().decode(RootFriends.self, from: data).response.items
                        
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
    func getPhotos(ownerId: Int, albumId: Int, completion: @escaping ((Result<[Photo], Error>) -> Void)) {
        let url = baseURL + Paths.getPhotos.rawValue
        
        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "owner_id": ownerId,
            "album_id": albumId,
            "extended": "1",
            "rev": TypeRev.antiСhronological.rawValue,
        ]
        
        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let photos = try JSONDecoder().decode(RootPhotos.self, from: data).response.items
                        completion(.success(photos))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    ///возвращает список фотографий, на которых отмечен пользователь
    func getUserPhotos(ownerId: Int, completion: @escaping ((Result<[Photo], Error>) -> Void)) {
        let url = baseURL + Paths.getUserPhotos.rawValue

        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "user_id": ownerId,
            "extended": "1",
            "rev": TypeRev.antiСhronological.rawValue,
        ]

        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let photos = try JSONDecoder().decode(RootPhotos.self, from: data).response.items
                        completion(.success(photos))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }


    ///получение списка альбомов по ID юзера
    func getAlbums(userId: Int, completion: @escaping ((Result<[Album], Error>) -> Void)) {
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
                        let albums = try JSONDecoder().decode(RootAlbums.self, from: data).response.items
                        completion(.success(albums))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    ///Получение групп пользователя
    func getGroups(userId: Int, completion: @escaping ((Result<[Group], Error>) -> Void)) {
        let url = baseURL + Paths.getGroups.rawValue
        
        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "user_id": userId,
            "extended": 1,
            "fields": "activity",
            "count": 500,
            "offset": 0,
        ]
        
        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let groups = try JSONDecoder().decode(GroupList.self, from: data).models
                        completion(.success(groups))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    ///Возвращает информацию о заданном сообществе или о нескольких сообществах.
    func getByIdGroups(ids: String, completion: @escaping (Result<[GroupInfo], Error>) -> Void) {
        let url = baseURL + Paths.getByIdGroups.rawValue
        
        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "fields": "members_count,description,activity",
            "group_ids": ids
        ]
        
        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let groupsInfo = try JSONDecoder().decode(GroupResponseInfo.self, from: data).response
                        completion(.success(groupsInfo))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    //Получение групп по поисковому запросу
    func searchGroups(textSearch: String, completion: @escaping (Result<[Group], Error>) -> Void) {
        let url = baseURL + Paths.searchGroups.rawValue
        
        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "q": textSearch,
            "count": 500,
            "type": "group",
            "offset": 0,
        ]
        
        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let groups = try JSONDecoder().decode(GroupList.self, from: data).models
                        completion(.success(groups))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func joinGroup(groupId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + Paths.joinGroup.rawValue

        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "group_id": groupId,
        ]
        
        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let _ = try JSONDecoder().decode(GroupResponse.self, from: data)
                        completion(.success(true))
                    } catch {
                        completion(.failure(VKError.limitIsexceeded(message: "Превышено ограничение на количество вступлений.")))
                    }
                }
            }
        }
    }

    func leaveGroup(groupId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + Paths.leaveGroup.rawValue

        let parameters: Parameters = [
            "access_token": token,
            "v": versionVKAPI,
            "group_id": groupId,
        ]

        AF.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success( _):
                if let data = response.data {
                    do {
                        let _ = try JSONDecoder().decode(GroupResponse.self, from: data)
                        completion(.success(true))
                    } catch {
                        completion(.failure(VKError.cannotDeserialize(message: error.localizedDescription)))
                    }
                }
            }
        }
    }
}
