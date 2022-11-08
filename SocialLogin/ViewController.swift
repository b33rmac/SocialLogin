//
//  ViewController.swift
//  SocialLogin
//
//  Created by smh on 2022/11/04.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // 네이버 로그인
    @IBAction func naverLoginButtonTapped(_ sender: UIButton) {
        naverLoginInstance?.requestThirdPartyLogin()
    }
    
    // 로그아웃
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        naverLoginInstance?.requestDeleteToken()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        naverLoginInstance?.delegate = self
    }
    
    func getInfo() {
        // Access Token 유효 여부 체크
        guard let isValidACT = naverLoginInstance?.isValidAccessTokenExpireTimeNow(), isValidACT else { return }
        
        guard let tokenType = naverLoginInstance?.tokenType else { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        
        let url = URL(string: "https://openapi.naver.com/v1/nid/me")!
        let authorization = "\(tokenType) \(accessToken)"
        
        let request = AF.request(url, method: .get, headers: ["Authorization": authorization])
        request.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let id = object["id"] as? String else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            
            self.idLabel.text = id
            self.nameLabel.text = name
            self.emailLabel.text = email
        }
    }

}

extension ViewController: NaverThirdPartyLoginConnectionDelegate {
    
    // 로그인 성공 시, 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print(#function)
        getInfo()
    }
    
    // Refresh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print(#function)
    }
    
    // 로그아웃(연동해제) 시, 호출
    func oauth20ConnectionDidFinishDeleteToken() {
        print(#function)
    }
    
    // 에러 처리
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("❌ Error")
        print(error.localizedDescription)
    }
    
}
