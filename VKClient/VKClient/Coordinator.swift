//
//  Coordinator.swift
//  VKClient
//
//  Created by Ilya on 13.11.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinator: [Coordinator] { get }
    var onCompleted: (() -> Void)? { get set }
    
    func start()
}
