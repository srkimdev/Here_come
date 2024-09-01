//
//  UIViewController+Extension.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case presentNavigation
        case presentFull
        case push
    }
    
    func transitionScreen<T: UIViewController>(vc: T, style: TransitionStyle) {
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFull:
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func dismissWithDelay(delay: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: delay, animations: {
            self.dismiss(animated: true, completion: completion)
        })
    }
    
    func showDeleteAlert(postId: String, completionHandler: @escaping (()) -> Void) {

        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
            NetworkManager.shared.deletePost(postId: postId)
            completionHandler(())
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(delete)
        
        present(alert, animated: true)
    }
    
    func BackButton() {
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        item.tintColor = Custom.Colors.seaColor
        navigationItem.leftBarButtonItem = item
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}
