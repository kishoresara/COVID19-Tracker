//
//  DetailsViewController.swift
//  Amrita Events
//
//  Created by kishore saravanan on 12/01/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

import UIKit

var StateClicked = String()
var DistrictNames: [String] = []
var DistrictCaseCount: [Int] = []

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 113
        tableview.backgroundColor = UIColor.darkGray
        
        var state_num_pointer = 0
        for i in 0..<statelist.count {
            if( StateClicked == statelist[i]) {
                state_num_pointer = i
            }
        }
        var total_case_check = 0
        for i in 0..<distlist[state_num_pointer].count {
            if (distlist[state_num_pointer][i] != "-") {
                DistrictNames.append(distlist[state_num_pointer][i])
            }
            if (distcount[state_num_pointer][i] != 0) {
                DistrictCaseCount.append(distcount[state_num_pointer][i])
                total_case_check += distcount[state_num_pointer][i]
            }
        }
        if total_case_check != total_state_count[state_num_pointer] {
            DistrictNames.append("District Unknown")
            DistrictCaseCount.append(total_state_count[state_num_pointer] - total_case_check)
        }
        
        for _ in 0..<DistrictCaseCount.count {
            for j in 1...DistrictCaseCount.count - 1 {
                if DistrictCaseCount[j-1] < DistrictCaseCount[j] {
                    let largerValue = DistrictCaseCount[j-1]
                    DistrictCaseCount[j-1] = DistrictCaseCount[j]
                    DistrictCaseCount[j] = largerValue
                    //print(largerValue)
                    
                    let tempstr = DistrictNames[j-1]
                    DistrictNames[j-1] = DistrictNames[j]
                    DistrictNames[j] = tempstr
                }
            }
        }
        
        print("distnaam",DistrictNames)
        print("dictcont",DistrictCaseCount)
        
       
    }
    
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.darkGray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DistrictNames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DistrictTableCell
        
        cell.DistrictName.text = DistrictNames[indexPath.row]
        cell.ConfirmedTotal.text = String(DistrictCaseCount[indexPath.row])
        cell.backgroundColor = UIColor.black
        cell.DeltaConfirmed.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //eventIdGlobal = indexPath.row
        //eventIdGlobal += 1
        //MapOrList = 1
        //performSegue(withIdentifier: "listSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
