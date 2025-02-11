//
//  EventsViewController.swift
//  COVID19 Tracker
//
//  Created by kishore saravanan on 11/01/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

import UIKit
var eventIdGlobal = Int()
var MapOrList = Int()
var sortedState: [String] = []
var deceased_state_count_daily: [Int] = []
var confirmed_state_count_daily: [Int] = []
var recovered_state_count_daily: [Int] = []
var india_deltacon = String()
var india_deltarec = String()
var india_deltaded = String()
var labellarr: [Int] = []
var decnumarr: [Int] = []
var recnumarr: [Int] = []
var dectodarr: [Int] = []
var rectodarr: [Int] = []
var contodarr: [Int] = []

var StateCode: [String] = ["KL", "DL", "TG", "RJ", "HR", "UP", "LA", "TN", "JK", "KA", "MH", "PB", "AP", "UT", "OR", "PY", "WB", "CH", "CT", "GJ", "HP", "MP", "BR", "MN", "MZ", "GA", "AN", "JH", "AS", "AR", "DN", "TR", "DD", "LD", "ML", "NL", "SK"]

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var titleArray = [String]()
    var locationArray = [String]()
    var dateArray = [String]()
    var timeArray = [String]()
    var temp = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.selectedIndex = 1//required value
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 200
        tableview.backgroundColor = UIColor.darkGray
        navigationController?.navigationBar.barTintColor = UIColor.black
        print(decnumarr)
        print(labellarr)
        print("whiooopsie")
        guard let url = NSURL(string: "https://api.covid19india.org/data.json") else { print("hu"); return }
        do {
            let data = try Data(contentsOf: url as URL)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [String:Any] else { print("hi");return }
            guard let arr2 = array["statewise"] as? [Any] else { print("ho");return }
            guard let casesDict = arr2[0] as? [String : Any] else { print("fooo"); return }
            guard let totconf = casesDict["confirmed"] as? String else {print("hoou"); return }
            guard let totdec = casesDict["deaths"] as? String else { return }
            guard let totrec = casesDict["recovered"] as? String else { return }
            guard let totact = casesDict["active"] as? String else { return }
            guard let deltaded = casesDict["deltadeaths"] as? String else { return }
            guard let deltacon = casesDict["deltaconfirmed"] as? String else { return }
            guard let deltarec = casesDict["deltarecovered"] as? String else { return }
            india_total = totconf
            india_deceased = totdec
            india_recovered = totrec
            india_active = totact
            india_deltacon = deltacon
            india_deltarec = deltarec
            india_deltaded = deltaded
            print (india_recovered,india_deceased,india_total)
            for index in 1..<arr2.count {
                guard let stateDict = arr2[index] as? [String:Any] else {print("s"); return }
                guard let state = stateDict["statecode"] as? String else { return }
                guard let nstat = stateDict["state"] as? String else {return}
                guard let staterec = stateDict["recovered"] as? String else { return }
                guard let stateded = stateDict["deaths"] as? String else { return }
                guard let stateact = stateDict["active"] as? String else { return }
                guard let statetot = stateDict["confirmed"] as? String else { return }
                guard let DeathTod = stateDict["deltadeaths"] as? String else { return }
                guard let ConfirmT = stateDict["deltaconfirmed"] as? String else { return }
                guard let RecoverT = stateDict["deltarecovered"] as? String else { return }
                var state_pos = Int()
                
                for i in 0..<sortedState.count {
                    if sortedState[i] == nstat {
                        state_pos = i
                    }
                }
                if sortedState.contains(nstat) {
                    confirmed_state_count_daily[state_pos] = Int(ConfirmT)!
                    recovered_state_count_daily[state_pos] = Int(RecoverT)!
                    deceased_state_count_daily[state_pos] = Int(DeathTod)!
                    recovered_state_count[state_pos] = Int(staterec)!
                    deceased_state_count[state_pos] = Int(stateded)!
                    active_state_count[state_pos] = Int(stateact)!
                    total_state_count[state_pos] = Int(statetot)!
                }
            }
        }
        catch {
            print(error)
        }
        labellarr = total_state_count
        decnumarr = deceased_state_count
        recnumarr = recovered_state_count
        dectodarr = deceased_state_count_daily
        rectodarr = recovered_state_count_daily
        contodarr = confirmed_state_count_daily
        labellarr.append(Int(india_total)!)
        decnumarr.append(Int(india_deceased)!)
        recnumarr.append(Int(india_recovered)!)
        dectodarr.append(Int(india_deltaded)!)
        rectodarr.append(Int(india_deltarec)!)
        contodarr.append(Int(india_deltacon)!)
        sortedState.append("India")
        //print(sortedState.count,labellarr.count,decnumarr.count,dectodarr.count)
        for _ in 0..<labellarr.count {
            for j in 1...labellarr.count - 1 {
                if labellarr[j-1] < labellarr[j] {
                    let largerValue = labellarr[j-1]
                    labellarr[j-1] = labellarr[j]
                    labellarr[j] = largerValue
                    //print(largerValue)
                    var temp = decnumarr[j-1]
                    decnumarr[j-1] = decnumarr[j]
                    decnumarr[j] = temp
                    temp = recnumarr[j-1]
                    recnumarr[j-1] = recnumarr[j]
                    recnumarr[j] = temp
                    temp = dectodarr[j-1]
                    dectodarr[j-1] = dectodarr[j]
                    dectodarr[j] = temp
                    temp = rectodarr[j-1]
                    rectodarr[j-1] = rectodarr[j]
                    rectodarr[j] = temp
                    temp = contodarr[j-1]
                    contodarr[j-1] = contodarr[j]
                    contodarr[j] = temp
                    let tempstr = sortedState[j-1]
                    sortedState[j-1] = sortedState[j]
                    sortedState[j] = tempstr
                }
            }
        }
    }
    func bubbleSort(arr1:inout [Int], arr2:inout [Int], arr3:inout [Int], arr4:inout [Int], arr5:inout [Int], arr6:inout [Int]) {
        let n = arr1.count
        for i in 0..<n-1 {
            for j in 0..<n-i-1 {
                if (arr1[j] > arr1[j+1]) {
                    var temp = arr1[j]
                    arr1[j] = arr1[j+1]
                    arr1[j+1] = temp
                    print(temp)
                    
                    temp = arr2[j]
                    arr2[j] = arr2[j+1]
                    arr2[j+1] = temp
                    
                    temp = arr3[j]
                    arr3[j] = arr3[j+1]
                    arr3[j+1] = temp
                    
                    temp = arr4[j]
                    arr4[j] = arr4[j+1]
                    arr3[j+1] = temp
                    
                    temp = arr5[j]
                    arr5[j] = arr5[j+1]
                    arr5[j+1] = temp
                    
                    temp = arr5[j]
                    arr5[j] = arr5[j+1]
                    arr5[j+1] = temp
                    
                    temp = arr6[j]
                    arr6[j] = arr6[j+1]
                    arr6[j+1] = temp
                    
                    
                }
            }
        }
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.darkGray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventListTableViewCell
        cell.titleLabel.text =  sortedState[indexPath.row]
        cell.countlabel.text =  String(labellarr[indexPath.row])
        cell.decnum.text = String(decnumarr[indexPath.row])
        cell.recnum.text = String(recnumarr[indexPath.row])
        cell.dectod.text = String(dectodarr[indexPath.row])
        cell.rectod.text = String(rectodarr[indexPath.row])
        cell.contod.text = String(contodarr[indexPath.row])
        cell.backgroundColor = UIColor.black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        StateClicked = sortedState[indexPath.row]
        DistrictNames.removeAll()
        DistrictCaseCount.removeAll()
        if(statelist.contains(sortedState[indexPath.row]))
        {
            performSegue(withIdentifier: "listSegue", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
 
}
