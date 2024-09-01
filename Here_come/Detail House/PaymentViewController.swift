//
//  PaymentViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/29/24.
//

import UIKit
import SnapKit
import WebKit
import iamport_ios
import Toast

final class PaymentViewController: BaseViewController {
    
    lazy var wkWebView: WKWebView = {
        var view = WKWebView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    var data: House?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func configureHierarchy() {
        view.addSubview(wkWebView)
    }
    
    override func configureLayout() {
        wkWebView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        
        guard let data else { return }
        
        let payment = IamportPayment(
                pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
                merchant_uid: "ios_\(APIKey.Key)_\(Int(Date().timeIntervalSince1970))",
                amount: "100").then {
            $0.pay_method = PayMethod.card.rawValue
            $0.name = "\(data.title)"
            $0.buyer_name = "김성률"
            $0.app_scheme = "sesac"
        }
        
        Iamport.shared.paymentWebView(webViewMode: self.wkWebView, userCode: "imp57573124", payment: payment) { [weak self] iamportResponse in
            print(String(describing: iamportResponse))
            
            let query = PaymentQuery(imp_uid: (iamportResponse?.imp_uid)!, post_id: data.postId)
            
            NetworkManager.shared.callRequest(router: Router.payments(query: query), responseType: PaymentModel.self) { response in
                switch response {
                case .success:
                    self?.poptoast {
                        self?.view.makeToast("결제가 완료되었습니다.", position: .bottom)
                    }
                case .failure(let error):
                    print("paryment \(error)")
                }
            }
            
            
//            NetworkManager.shared.payments(postId: data.postId, userId: (iamportResponse?.imp_uid)!) { value in
//                print(value)
//                self?.poptoast {
//                    self?.view.makeToast("결제가 완료되었습니다.", position: .bottom)
//                }
//                
//            }
            
        }
        
    }
    
    func poptoast(completionHandler: @escaping () -> Void) {
        navigationController?.popViewController(animated: true)
        completionHandler()
    }
    
}
