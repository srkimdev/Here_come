//
//  CommentViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/24/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CommentViewController: BaseViewController {
    
    let commentLabel = UILabel()
    let commentTableView = UITableView()
    let belowView = UIView()
    let textFieldView = UIView()
    let commentTextField = UITextField()
    let sendButton = UIButton()
    
    let viewModel = CommentViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTableView.register(CommentPostTableViewCell.self, forCellReuseIdentifier: CommentPostTableViewCell.identifier)
        
        bind()
    }
    
    override func configureHierarchy() {
        
        view.addSubview(commentLabel)
        view.addSubview(commentTableView)
        view.addSubview(belowView)
        view.addSubview(textFieldView)
        view.addSubview(commentTextField)
        view.addSubview(sendButton)
        
    }
    
    override func configureLayout() {
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(belowView.snp.top)
        }
        
        belowView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }

        textFieldView.snp.makeConstraints { make in
            make.centerY.equalTo(belowView)
            make.leading.equalTo(belowView.snp.leading).offset(16)
            make.height.equalTo(40)
            make.width.equalTo(320)
        }

        commentTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(textFieldView).inset(12)
            make.centerY.equalTo(textFieldView)
        }

        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(belowView)
            make.trailing.equalTo(belowView.snp.trailing).inset(16)
            make.size.equalTo(40)
        }
        
    }
    
    override func configureUI() {
        
        commentLabel.text = "댓글"
        commentLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        commentTableView.separatorStyle = .none
        
        textFieldView.layer.masksToBounds = true
        textFieldView.layer.cornerRadius = 20
        textFieldView.backgroundColor = .systemGray5

        commentTextField.placeholder = "댓글을 입력해주세요"

        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        
    }
    
    func bind() {
        
        let input = CommentViewModel.Input(sendButtonTap: sendButton.rx.tap, inputText: commentTextField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.updateTableView
            .bind(to: commentTableView.rx.items(cellIdentifier: CommentPostTableViewCell.identifier, cellType: CommentPostTableViewCell.self)) { (row, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
                  
    }
    
}
