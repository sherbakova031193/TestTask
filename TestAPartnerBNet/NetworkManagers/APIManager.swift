//
//  APIManager.swift
//  TestAPartnerBNet
//
//  Created by Елизавета Щербакова on 10.08.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import Foundation
import Alamofire

class APIManager  {
    
    let token = "B7HWUyF-36-comn3Fx"
    let urlString = "https://bnet.i-partner.ru/testAPI/"
    let userDefaults = UserDefaults.standard
    
    
    init() {
        checkSession()
    }
    
    private func post(parameters: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        
        let httpHeaders = HTTPHeaders([HTTPHeader.init(name: "token", value: token)])
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: httpHeaders)
            .responseJSON { response in

                switch response.result {
                case .success:
                    completion(response.data, response.error)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    private func checkSession() {
        
        let sessionIdentifier = userDefaults.string(forKey: "sessionIdentifier")
        print(sessionIdentifier ??  "")
        if sessionIdentifier == nil {
            createNewSession()
        }
    }
    
    private func createNewSession() {
        
        let parameter = ["a" : "new_session"]
        
        
        post(parameters: parameter) { (data, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }

            do {
                let newSession = try JSONDecoder().decode(NewSession.self, from: data)
                let sessionIdentifier = newSession.data.session
                self.userDefaults.set(sessionIdentifier, forKey: "sessionIdentifier")
                print(sessionIdentifier)
            }  catch {
                print (error.localizedDescription)
            }
        }
    }
    
    public func getEntries(completion: @escaping ([EntryData?]?, Error?) -> Void) {
        
       var entries: [EntryData?] = []
       guard let sessionIdentifier = userDefaults.string(forKey: "sessionIdentifier") else { return }
        let parameters = ["a" : "get_entries", "session" : "\(sessionIdentifier)"]
        
        post(parameters: parameters) { data, error in
           

            guard let data = data else {
                print(String(describing: error))
                completion(nil, error)
                return
            }
            
            print(String(data: data, encoding: .utf8)!)
            
            do {
                
                let entriesData = try JSONDecoder().decode(EntriesData.self, from: data)
                entries = entriesData.data[0]
                print(entries)
                completion(entries, nil)
            }  catch {
                print (error.localizedDescription)
                completion(nil, nil)
                
            }
        }
    }
    
    public func addEntry(body: String, completion: @escaping (Error?) -> Void) {
        
        
        guard let sessionIdentifier = userDefaults.string(forKey: "sessionIdentifier") else { return }
        let parameters = ["a" : "add_entry", "session" : "\(sessionIdentifier)", "body" : "\(body)"]
        
        post(parameters: parameters) { data, error in
            guard data != nil else {
                print(String(describing: error))
                completion(error)
                return
            }
            completion(nil)
            
        }
    }
}
