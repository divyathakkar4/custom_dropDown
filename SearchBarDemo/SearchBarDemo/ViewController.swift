//
//  ViewController.swift
//  SearchBarDemo
//
//  Created by Admin on 28/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var tblheight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var lblheight: NSLayoutConstraint!
    
    var isKeyboardOpen:Bool = false
    
    
    var searchActive : Bool = false
    var arrData = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle","ARCHETYPE","ARCHITECT","AROMA","AROUSE","AROUSED","BADASS","BADASSERY","BALANCE","BALANCED","BALLOFFIRE","BALLSY","BALMY","BAM","CAJOLE","CALM","CALMATIVECALMING","CAN","CANDESCENT","CANDIDLY","DABBLE","DAIMON","EAGER","EXULTINGLY","FAVOURITE","FEARLESS","GENTLE","GENTLEMAN","HAPPINESS","HAPPY","IMPRESSES","IMPRESSIVE","INVENTOR","INVENTORY","JOYFULLY","JOYOUS","JOYOUSLY","KNOWING","KNOWINGLY","KNOWLEDGE","LIGHTEN","LIKABLE","LIKES","MAGIC","MAGICIAN","MANAGE","NOON","NORMAL","ORDER","OUTCOME","OVER","OVERTOOK","PHILOSOPHICAL","PILOT","PLAY","POSITIVE","REFLECTIVE","RELIEVED","SCION","SECOND","SELFLESS"]
    
    var arrFiltered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        let screenHeight = UIScreen.main.bounds.height
        if self.tableView.contentSize.height  > screenHeight{
            if isKeyboardOpen == true{
                 self.tblheight.constant = screenHeight - 320
            }else{
                 self.tblheight.constant = screenHeight - 100
            }
           
        }else{
            self.tblheight.constant = self.tableView.contentSize.height//
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return arrFiltered.count
        }
        return arrData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! labelTableViewCell
        if(searchActive){
            cell.lblCity.text = arrFiltered[indexPath.row]
        } else {
            cell.lblCity.text = arrData[indexPath.row]
        }
        lblheight = cell.lblheight
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.isHidden = false
        arrFiltered = arrData.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        if(arrFiltered.count == 0){
            searchActive = false;
            tableView.isHidden = true
        } else {
            searchActive = true;
            tableView.isHidden = false
            
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("start thayu")
        isKeyboardOpen = true
        viewWillLayoutSubviews()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("end thayu")
        self.view.endEditing(true)
        isKeyboardOpen = false
        searchBar.resignFirstResponder()
        viewWillLayoutSubviews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isKeyboardOpen = false
        self.view.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

