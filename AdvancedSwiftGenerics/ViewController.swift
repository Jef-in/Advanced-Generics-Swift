//
//  ViewController.swift
//  AdvancedSwiftGenerics
//
//  Created by Jefin on 01/06/19.
//  Copyright © 2019 jefin. All rights reserved.
//

import UIKit

struct Video: Decodable {
    
    let name: String
    let id: Int
    
}
struct user: Decodable {
    
    let videos: [Video]
}

struct Courses: Decodable {
    
    let id: Int
    let name: String
    let link: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
    super.viewDidLoad()
        
   //MARK:- Function Call
        
    fetchGenericData(urlString: "http://api.letsbuildthatapp.com/youtube/home_feed") { (user: user) in
    user.videos.forEach({print($0.name,$0.id)})
    }
        
    fetchGenericData(urlString: "http://api.letsbuildthatapp.com/jsondecodable/courses") { (courses: [Courses]) in
            courses.forEach({print($0.id,$0.name,$0.link)})
        }
    }

    //MARK:- Generic function definition Code By Jefin
    
 fileprivate func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ())
    {
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            guard let data = data else {return}
            do
            {
                let object = try JSONDecoder().decode(T.self,from: data)
                completion(object)
                
            } catch let jsonError {
                
                print(jsonError)
            }
            
        }.resume()
        
    }
  
    
}



