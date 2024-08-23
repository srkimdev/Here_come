//
//  DetailViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/21/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DetailViewController: BaseViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()

    let categoryBackView = UIView()
    let categoryLabel = UILabel()

    let profileImage = UIImageView()
    let userName = UILabel()
    let locationLabel = UILabel()

    let titleLabel = UILabel()
    let contentLabel = UILabel()

    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewLayout())

    let seperateLine = UIView()
    let commentLabel = UILabel()
    let commentTableView = UITableView()

    let belowView = UIView()
    let textFieldView = UIView()
    let commentTextField = UITextField()
    let sendButton = UIButton()

    let viewModel = DetailViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        commentTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        imageCollectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)

        bind()
    }

    override func viewDidLayoutSubviews() {
        categoryBackView.layer.cornerRadius = categoryBackView.frame.width / 2
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }

    override func configureHierarchy() {

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(categoryBackView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(profileImage)
        contentView.addSubview(userName)
        contentView.addSubview(locationLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(seperateLine)
        contentView.addSubview(commentLabel)
        contentView.addSubview(commentTableView)
        view.addSubview(belowView)
        belowView.addSubview(textFieldView)
        textFieldView.addSubview(commentTextField)
        belowView.addSubview(sendButton)
    }

    override func configureLayout() {

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }

        categoryBackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }

        profileImage.snp.makeConstraints { make in
            make.top.equalTo(categoryBackView.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.size.equalTo(40)
        }

        userName.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
        }

        locationLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImage.snp.bottom)
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(16)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(16)
        }

        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(320)
        }

        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(10)
        }

        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.height.equalTo(20)
        }

        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(0)
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

        categoryBackView.backgroundColor = .systemGray5
        categoryBackView.layer.masksToBounds = true

        profileImage.layer.masksToBounds = true
        profileImage.image = UIImage(named: "profile_10")

        userName.text = "말챠"
        userName.font = .systemFont(ofSize: 15, weight: .bold)

        locationLabel.text = "제주시 애월읍"
        locationLabel.font = .systemFont(ofSize: 15)

        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 0

        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0

        seperateLine.backgroundColor = .systemGray5

        commentLabel.text = "댓글"
        
        commentTableView.isScrollEnabled = false
        commentTableView.estimatedRowHeight = 200
        commentTableView.rowHeight = UITableView.automaticDimension

        textFieldView.layer.masksToBounds = true
        textFieldView.layer.cornerRadius = 20
        textFieldView.backgroundColor = .systemGray5

        commentTextField.placeholder = "댓글을 입력해주세요"

        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
    }

    func bind() {

        let input = DetailViewModel.Input(inputText: commentTextField.rx.text.orEmpty, inputButtonTap: sendButton.rx.tap)
        let output = viewModel.transform(input: input)

        output.getPost
            .compactMap{ $0 }
            .bind(with: self) { owner, value in
                owner.titleLabel.text = value.title
                owner.contentLabel.text = value.content
            }
            .disposed(by: disposeBag)
        
        output.ImageArray
            .bind(to: imageCollectionView.rx.items(cellIdentifier: DetailCollectionViewCell.identifier, cellType: DetailCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
            }
            .disposed(by: disposeBag)

        output.updateComment
            .bind(to: commentTableView.rx.items(cellIdentifier: CommentTableViewCell.identifier, cellType: CommentTableViewCell.self)) { (row, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        commentTableView.rx.observe(CGSize.self, "contentSize")
            .subscribe(onNext: { [weak self] size in
                guard let self = self, let size = size else { return }
                self.commentTableView.snp.updateConstraints { make in
                    make.height.equalTo(size.height)
                }
                commentTextField.text = nil
                
            })
            .disposed(by: disposeBag)
        
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func imageCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.width - 32
        layout.itemSize = CGSize(width: width, height: width)
        layout.scrollDirection = .horizontal
        return layout
    }
}
