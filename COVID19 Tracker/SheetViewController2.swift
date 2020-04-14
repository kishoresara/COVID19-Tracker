//
//  SheetViewController.swift
//  Amrita Events
//
//  Created by kishore saravanan on 13/02/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

import UIKit
//import FittedSheets

var eventNameGlobal = String()

public class SheetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
 
    @IBOutlet weak var SheetTable: UITableView!
    

    var arrTitle = [String]()
    var tempSTR = String()

    override public func viewDidLoad() {
        super.viewDidLoad()
        SheetTable.delegate = self
        SheetTable.dataSource = self
        SheetTable.rowHeight = 94
        // Do any additional setup after loading the view.
        var arrTitle: [String] = []
              var i = Int()
        i=0
        //while(i<arraymark.count){
            //arrTitle[i] = arraymark[i].title as! String
            //i = i+1
        //}
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraymark.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SheetTableViewCell
        cell.TitleCell.text = arraymark[indexPath.row].title as! String
        cell.LocationCell.text = arraymark[indexPath.row].subtitle as! String
        cell.largeContentTitle = cell.TitleCell.text
        //cell.TitleCell.text = "yo"
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventIdGlobal = indexPath.row
        eventIdGlobal += 1
        EventNameGlobal = tableView.cellForRow(at: indexPath)!.largeContentTitle!
        MapOrList = 2
        performSegue(withIdentifier: "collectionselectSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //eventIdGlobal = indexPath.row
    //eventIdGlobal += 1
    //MapOrList = 1
    //performSegue(withIdentifier: "listSegue", sender: self)
    //tableView.deselectRow(at: indexPath, animated: true)

}

