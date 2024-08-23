//
//  LoginViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift

final class LoginViewController: BaseViewController {
    
    let idTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    override func configureLayout() {
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
    }
    
    override func configureUI() {
        navigationItem.title = "LOGIN"
        
        idTextField.layer.borderColor = UIColor.lightGray.cgColor
        idTextField.layer.borderWidth = 1
        idTextField.addLeftPadding()
        idTextField.placeholder = "아이디"
        
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.addLeftPadding()
        passwordTextField.placeholder = "비밀번호"
        
        loginButton.backgroundColor = .black
        loginButton.setTitle("로그인하기", for: .normal)
        
        idTextField.text = "compose1@coffee.com"
        passwordTextField.text = "1234"
        
    }
    
    func bind() {

        let loginInfo = Observable.combineLatest(idTextField.rx.text.orEmpty.asObservable(), passwordTextField.rx.text.orEmpty.asObservable())
        
        let input = LoginViewModel.Input(loginButtonTap: loginButton.rx.tap, loginInfo: loginInfo)
        let output = viewModel.transform(input: input)
        
        output.loginValidation
            .bind(with: self) { owner, _ in
                let vc = TabBarViewController()
                owner.transitionScreen(vc: vc, style: .presentFull)
            }
            .disposed(by: disposeBag)
        
    }
    
}
