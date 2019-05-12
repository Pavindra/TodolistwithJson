//
//  ViewController.swift
//  TodolistwithJson
//
//  Created by Pavindra Weththasinghe on 30/4/19.
//  Copyright © 2019 Pavindra Weththasinghe. All rights reserved.
//

import UIKit


enum selectScope:Int
{
    case task = 0
    case cat = 1
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listTableView: UITableView!
    

    var tasks = [Tasks]()
    var SortedArr = [Tasks]()
    var isSorted = false
    
//    @IBAction func btnCat(_ sender: Any) {
//        //isSorted = false
//        self.tasks.sort() { $0.cat < $1.cat}
//        self.listTableView.reloadData()
//    }
    @IBAction func btnSort(_ sender: Any) {
        //isSorted = false
        self.tasks.sort() { $0.task < $1.task}
        self.listTableView.reloadData()
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.search()
        self.search()
        if let path = Bundle.main.path(forResource: "JSONData", ofType: "json"){
           let url = URL(fileURLWithPath: path)
            //print(path)
            do{
                let data = try Data(contentsOf: url, options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
               print(json)
                guard let jsonArray = json as? [[String: Any]] else {
                    return
                }
                print (jsonArray)
                
                for task in jsonArray
                {
                    tasks.append(Tasks(task))
                    
                }
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            }catch
            {
                print(error)
            }
        }
        else
        {
            print("Invalid Path")
        }
        // Do any additional setup after loading the view.
    }
    func search()
    {
    let searchB = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 75))
    searchB.showsScopeBar = true
    searchB.scopeButtonTitles = ["Task","Category"]
    searchB.selectedScopeButtonIndex = 0
    searchB.delegate = self
    self.listTableView.tableHeaderView = searchB
    }
//
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty
        {
            isSorted = false
            listTableView.reloadData()
        }
        else
        {
            isSorted = true
            sortedTableview(num: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }

    func sortedTableview(num : Int, text : String)
    {
        switch num {
        case selectScope.task.rawValue:
            SortedArr = tasks.filter({(mod)-> Bool in
                return mod.task.lowercased().contains(text.lowercased())
            })
            self.listTableView.reloadData()
            
         case selectScope.cat.rawValue:
            SortedArr = tasks.filter({(mod)-> Bool in
                return mod.cat.lowercased().contains(text.lowercased())
            })
            self.listTableView.reloadData()
        default:
            print("Input is Invalid")
            listTableView.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return isSorted ? SortedArr.count: tasks.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lableTask.text = isSorted ? SortedArr[indexPath.row].task : tasks[indexPath.row].task
        cell.lableCat.text = isSorted ? SortedArr[indexPath.row].cat : tasks[indexPath.row].cat
        cell.lableImp.text = isSorted ? String(SortedArr[indexPath.row].isImp) : String(tasks[indexPath.row].isImp)
        if(cell.lableCat.text == "Home")
        {
            cell.lableTask.textColor = UIColor.blue
            cell.lableCat.textColor = UIColor.gray
            
        }
        else if (cell.lableCat.text == "Uni")
        {
            cell.lableTask.textColor = UIColor.purple
            cell.lableCat.textColor = UIColor.gray
        }
        else
        {
            cell.lableTask.textColor = UIColor.brown
            cell.lableCat.textColor = UIColor.gray
        }
        if(cell.lableImp.text == "true")
        {
           // cell.lableImp.text = isSorted ? String(SortedArr[indexPath.row].isImp) : String(tasks[indexPath.row].isImp)
            cell.lableImp.text = "🛑"
        }
        else
        {
            cell.lableImp.text = " "
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

