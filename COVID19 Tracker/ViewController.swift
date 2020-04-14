//
//  ViewController.swift
//  COVID19 Tracker
//
//  Created by kishore saravanan on 19/12/19.
//  Copyright © 2019 kishore saravanan. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

var india_total = ""
var india_deceased = ""
var india_recovered = ""
var india_active = ""
var deceased_state_count: [Int] = []
var active_state_count: [Int] = []
var total_state_count: [Int] = []

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var proceedButton: CustomButton!
    @IBOutlet weak var Contentframe: UIView!
    let dataSource = ["0","1","2"]
    var currentViewControllerIndex = 0
    @IBAction func proceedButtonPressed(_ sender: Any) {
        let myController = storyboard?.instantiateViewController(identifier: "EventsViewController")
        myController?.modalPresentationStyle = .fullScreen
        self.present(myController!, animated: true, completion: nil)
        self.ShowActivitySpinner()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var temp_state = 0
        guard let url = NSURL(string: "https://api.covid19india.org/raw_data.json") else { return }
        do {
            let data = try Data(contentsOf: url as URL)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [String:Any] else { return }
            guard let arr = array["raw_data"] as? [Any] else { return }
            for patient in arr  {
                guard let patientDict = patient as? [String : Any] else { print("f"); return }
                guard let detectedstate = patientDict["detectedstate"] as? String else { return }
                if detectedstate != "" {
                    if (sortedState.isEmpty) {
                        sortedState.append(detectedstate)
                    }
                    if (sortedState.contains(detectedstate) == false ) {
                        sortedState.append(detectedstate)
                    }
                }
            }
        }
        catch {
            print(error)
        }
        while temp_state<sortedState.count{               // initalise count of cases in each state as 0
            confirmed_state_count_daily.append(0)
            recovered_state_count_daily.append(0)
            deceased_state_count_daily.append(0)
            recovered_state_count.append(0)
            deceased_state_count.append(0)
            active_state_count.append(0)
            total_state_count.append(0)
            temp_state = temp_state + 1
        }
        configurePageViewController()
    }
    
    
    
    
    func configurePageViewController() {
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else { return }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        Contentframe.addSubview(pageViewController.view)
        let color = UIColor(red: 0x1F, green: 0x21, blue: 0x24)
        pageViewController.view.backgroundColor = color
        let views: [String: Any] = ["pageView": pageViewController.view]
        Contentframe.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        Contentframe.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else { return }
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
    }
    
    func detailViewControllerAt(index: Int) -> IntroViewController? {
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: IntroViewController.self)) as? IntroViewController else {print("gon"); return nil}
        dataViewController.index = index
        dataViewController.VideoName = dataSource[index]
        return dataViewController
    }
}


extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? IntroViewController
        guard var currentIndex = dataViewController?.index else {return nil}
        currentViewControllerIndex = currentIndex
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? IntroViewController
        guard var currentIndex = dataViewController?.index else {return nil}
        if currentIndex == dataSource.count {
            return nil
        }
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        return detailViewControllerAt(index: currentIndex)
    }
}




