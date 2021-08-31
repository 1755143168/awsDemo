//
//  Info.swift
//  lastdemo
//
//  Created by Super on 2021/8/28.
//

import UIKit
import Amplify

class Info: UIViewController {

    @IBOutlet weak var InfoInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var id :String = UserDefaults.standard.value(forKey: "id") as! String
        print(">>>",id)
        Amplify.DataStore.query(Todo.self, byId: id) {
            switch $0 {
            case .success(let result):
                // result will be a single object of type Post?
                InfoInput.text = result?.description
                print("Posts: \(result)")
            case .failure(let error):
                print("Error on query() for type Post - \(error.localizedDescription)")
            }
        }
    }
    

    @IBAction func save(_ sender: Any) {
        var id :String = UserDefaults.standard.value(forKey: "id") as! String
        Amplify.DataStore.save(Todo(id: id,name: "lyle",description:InfoInput.text, password: "123123")) {
            switch $0 {
            case .success:
                print("《》《》《》")
            case .failure(let error):
                print("Error updating post - \(error.localizedDescription)")
            }
        }
//        func getexist() -> Void {
//        var id :String = UserDefaults.standard.value(forKey: "id") as! String
//        Amplify.DataStore.query(Todo.self, byId: id) {
//            switch $0 {
//            case .success(let result):
//                // result will be a single object of type Post?
//                var existingPost = result
//                existingPost?.description = InfoInput.text
//                print(existingPost!)
//                return existingPost!
//
////                print("Posts: \(result)")
//            case .failure(let error):
//                print("Error on query() for type Post - \(error.localizedDescription)")
//            }
//        }
//        }
        
        

        
    }
    @IBAction func quertAll(_ sender: Any) {
        Amplify.DataStore.query(Todo.self) {
            switch $0 {
            case .success(let result):
                // result will be of type [Post]
                print("查询所有数据: \(result)")
            case .failure(let error):
                print("Error on query() for type Post - \(error.localizedDescription)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
