//
//  ViewController.swift
//  lastdemo
//
//  Created by Super on 2021/8/26.
//

import UIKit
import Amplify
import Combine
import AppCenter
import AppCenterCrashes


class ViewController: UIViewController {
    var postsSubscription: AnyCancellable?
    
    @IBOutlet weak var acountInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var add: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppCenter.start(withAppSecret: "afbe496c-055f-42b8-8b3b-00c2da8a16ec", services:[
          Crashes.self
        ])
//        subscribeTodos()
        // Do any additional setup after loading the view.
    }
    
    func subscribeTodos() {
        print("开始订阅数据")
        postsSubscription
            = Amplify.DataStore.publisher(for: Todo.self)
                .sink(receiveCompletion: { completion in
                    print("订阅已完成: \(completion)")
                }, receiveValue: { mutationEvent in
                    print("订阅得到了这个值: \(mutationEvent)")

                    do {
                      let todo = try mutationEvent.decodeModel(as: Todo.self)

                      switch mutationEvent.mutationType {
                      case "create":
                        print("创建: \(todo)")
                      case "update":
                        print("更新: \(todo)")
                      case "delete":
                        print("删除: \(todo)")
                      default:
                        break
                      }

                    } catch {
                      print("模型无法解码: \(error)")
                    }
                })
    }
    
    
//    func performOnAppear() {
//        subscribeTodos()
//    }
    
//    func ce(e :Model)->Void{
//        Amplify.DataStore.save(e as! Model) {
//            switch $0 {
//            case .success:
//                print("更新")
//                return e
//            case .failure(let error):
//                print("Error updating post - \(error.localizedDescription)")
//            }
//        }
//    }
    
    
    @IBAction func addfun(_ sender: Any) {
        var todo = Todo(name: "lyle", description: "勇敢sam111", password: "123123")
        var id :String = UserDefaults.standard.value(forKey: "id") as! String
        
//        ce(e: todo)
        Amplify.DataStore.save(todo) {
            switch $0 {
            case .success:
                print("更新")
                todo.description = "牛牛"
                Amplify.DataStore.save(todo){ result in
                    print("genxin",result)
                }
            case .failure(let error):
                print("Error updating post - \(error.localizedDescription)")
            }
        }
        
        
//        Amplify.DataStore.save(todo){ result in
//            print("打印结果",result)
//        }
//            switch(result) {
//            case .success(let savedItem):
//                print("创建成功: \(savedItem.name)")
//            case .failure(let error):
//                print("创建失败: \(error)")
//            }
//        }
//            Amplify.API.mutate(request: .create(todo)) { event in
//                switch event {
//                case .success(let result):
//                    switch result {
//                    case .success(let todo):
//                        print("Successfully created the todo: \(todo)")
//                    case .failure(let graphQLError):
//                        print("Failed to create graphql \(graphQLError)")
//                    }
//                case .failure(let apiError):
//                    print("Failed to create a todo", apiError)
//                }
//            }
    }
    
    @IBAction func getfun(_ sender: Any) {
        
//        Amplify.API.query(request: .get(Todo.self, byId: "d28cd337-74e5-450b-be52-9e9d47e28333")) { event in
//                switch event {
//                case .success(let result):
//                    switch result {
//                    case .success(let todo):
////                        guard let todo = todo else {
////                            print("Could not find todo")
////                            return
////                        }
//                        print("Successfully retrieved todo: \(todo)",todo?.name)
//                    case .failure(let error):
//                        print("Got failed result with \(error.errorDescription)")
//                    }
//                case .failure(let error):
//                    print("Got failed event with error \(error)")
//                }
//            }
        Amplify.DataStore.query(Todo.self) {result in
            print("打印结果",result)
//            switch $0 {
//            case .success(let result):
//                // result will be of type [Post]
//                print("获取所有数据: \(result)")
//            case .failure(let error):
//                print("Error on query() for type Post - \(error.localizedDescription)")
//            }
        }
    }
    
    
    @IBAction func deletfun(_ sender: Any) {
        var todo = Todo(id: "715adfbe-5610-41e5-b794-6dc842a6d0f4", name: "测试")
            todo.description = "updated description"
            Amplify.API.mutate(request: .delete(todo)) { event in
                switch event {
                case .success(let result):
                    switch result {
                    case .success(let todo):
                        print("Successfully delet: \(todo)")
                    case .failure(let error):
                        print("Got failed result with",error)
                    }
                case .failure(let error):
                    print("Got failed event with error",error)
                }
            }
    }
    
    @IBAction func deletAll(_ sender: Any) {
        Amplify.DataStore.clear { result in
            switch result {
            case .success:
                print("DataStore cleared")
            case .failure(let error):
                print("Error clearing DataStore: \(error)")
            }
        }
    }
    
    @IBAction func Login(_ sender: UIButton) {
//        subscribeToPosts()
        var account = acountInput.text
        var password = passwordInput.text
        Amplify.DataStore.query(Todo.self, where: Todo.keys.name == account && Todo.keys.password == password) { result in
                switch(result) {
                case .success(let todos):
                    print("列表",todos)
                    if todos.count>0 {
                        UserDefaults.standard.set(todos[0].id, forKey:"id")//存id
                        UserDefaults.standard.synchronize()//设置同步
                        self.performSegue(withIdentifier: "login", sender: self)
                    }else{
                        let alert = UIAlertController(title: "Incorrect account or password!", message: nil, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1){
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
//                    for todo in todos {
//                        print("==== Todo ====")
//                        print("Name: \(todo.name)")
//                        if todo.name == account && todo.password == password {
//                            self.performSegue(withIdentifier: "login", sender: self)
//                        }else{
//                            self.present(alert, animated: true, completion: nil)
//                        }
//
//                    }
                case .failure(let error):
                    print("Could not query DataStore: \(error)")
                }
            }
    }
}

