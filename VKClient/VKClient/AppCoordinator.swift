//
//  AppCoordinator.swift
//  VKClient
//
//  Created by Ilya on 13.11.2021.
//


import UIKit
import Combine
import SwiftUI

class AppCoordinator: Coordinator {
    
    private(set) var childCoordinator: [Coordinator] = []
    private var cancellables: Set<AnyCancellable> = []
    
    var navigationController: UINavigationController
    var onCompleted: (() -> Void)?
    
    public init(navigationController: UINavigationController, onCompleted: (() -> Void)? = nil) {
        self.navigationController = navigationController
        self.onCompleted = onCompleted
    }
    
    let loginViewModel: LoginViewModel = LoginViewModel()
    var navigationViewModel = NavigationViewModel()
    
    func start() {
        
        let loginViewBinding = Binding<Bool>.init { [weak self] in
            guard let self = self else { return false }
            return self.loginViewModel.isUserAuthorized
        } set: { [weak self] newValue in
            guard let self = self else { return }
            self.loginViewModel.isUserAuthorized = newValue
        }
        
        let loginView = VKLoginWebView(isAuthorize: loginViewBinding)
        let loginViewController = UIHostingController(rootView: loginView)
        navigationController.pushViewController(loginViewController, animated: true)

        loginViewModel
            .$isUserAuthorized
            .removeDuplicates()
            .subscribe(on: RunLoop.main)
            .sink { [weak self] isUserLoggedIn in
                guard let self = self else { return }
                
                if isUserLoggedIn {
                    let mainView = self.createMainView()
               
//                    self.navigationController.navigationBar.clipsToBounds = true
                    
                      self.navigationController.pushViewController(mainView, animated: true)
//                    self.navigationController.navigationBar.topItem?.title = "Друзья"
                    self.navigationController.navigationBar.prefersLargeTitles = true
                } else {
                    self.navigationController.popToViewController(loginViewController, animated: true)
                }
            }
            .store(in: &cancellables)
        
        navigationViewModel
            .$tag
            .subscribe(on: RunLoop.main)
            .sink { [weak self] tag in
                guard let self = self else { return }
                
                if tag == 0 {
              
                    self.navigationController.navigationBar.topItem?.title = "Друзья"
                } else if tag == 1 {
                    self.navigationController.navigationBar.topItem?.title = "Группы"
//                    self.navigationController.navigationBar.prefersLargeTitles = true
                } else if tag == 2 {
                    self.navigationController.navigationBar.topItem?.title = "Новости"
                }
            }
            .store(in: &cancellables)
    }
    
    private func createMainView() -> UIViewController {
        let view = ContentView(navigationViewModel: navigationViewModel)
        return UIHostingController(rootView: view)
    }

}

class NavigationViewModel: ObservableObject {
    @Published var tag: Int = 0
}
