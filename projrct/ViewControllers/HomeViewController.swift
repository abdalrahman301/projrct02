//
//  HomeViewController.swift
//  projrct
//
//  Created by htu on 7/28/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics
import FirebaseCore
import FirebaseFirestore


class HomeViewController: UIViewController,UICollectionViewDelegate , UICollectionViewDataSource , UISearchResultsUpdating , UISearchBarDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching || scopeButtonPressed {
            return searchedperfume.count
        }else {
            return perfumeList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! MyCollectionViewCell
        if searching || scopeButtonPressed {
            cell.productimg.image = UIImage(named:searchedperfume[indexPath.row].PerfumeImage)
            cell.productname.text = searchedperfume[indexPath.row].perfumeName
            
            cell.price.text = ("\(searchedperfume[indexPath.row].PerfumePrice) jd")
            
        }else {
            
            cell.productimg.image = UIImage(named:perfumeList[indexPath.row].PerfumeImage)
                      cell.productname.text = perfumeList[indexPath.row].perfumeName
                      
                      cell.price.text = ("\(perfumeList[indexPath.row].PerfumePrice) jd")
                      
            
        }
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            searchedperfume.removeAll()
        
        for perfume in perfumeList {
            if perfume.perfumeName.lowercased().contains(searchText.lowercased()) && (perfume.perfumeGender == scopeButton || scopeButton == "All")
            {
        searchedperfume.append(perfume)
            }}}
        else {
            if scopeButtonPressed {
                searchedperfume.removeAll()
                let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
                for perfume in perfumeList {
                    if (perfume.perfumeGender == scopeButton || scopeButton == "All") {
                        searchedperfume.append(perfume)
                    }
                }
                searching = false
                MyCollectionView.reloadData()
            }
            else {
                searching = false
                searchedperfume.removeAll()
                searchedperfume = perfumeList
            }
            
        }
        MyCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedperfume.removeAll()
        MyCollectionView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchController.searchBar.text = ""
        scopeButtonPressed = true
        let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        searchedperfume.removeAll()
        for perfume in perfumeList {
            if (perfume.perfumeGender == scopeButton || scopeButton == "All"){
                searchedperfume.append(perfume)
            }
        }
        MyCollectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VCViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.DetailsViewController) as? DetailsViewController
        if searching || scopeButtonPressed {
            VCViewController?.imagerecieved = UIImage(named:searchedperfume[indexPath.row].PerfumeImage)!
            VCViewController?.namerecieved = ("\(searchedperfume[indexPath.row].perfumeName)")
            VCViewController?.pricerecieved = ("\(searchedperfume[indexPath.row].PerfumePrice) Jd")
            VCViewController?.descrecieved = ("\(searchedperfume[indexPath.row].perfumeDesc)")
        self.present((VCViewController)!, animated: true, completion: nil)
        }
        else {
            VCViewController?.imagerecieved = UIImage(named:perfumeList[indexPath.row].PerfumeImage)!
                       VCViewController?.namerecieved = ("\(perfumeList[indexPath.row].perfumeName)")
                       VCViewController?.pricerecieved = ("\(perfumeList[indexPath.row].PerfumePrice)")
            VCViewController?.descrecieved = ("\(perfumeList[indexPath.row].perfumeDesc)")
                   self.present((VCViewController)!, animated: true, completion: nil)
        }
    }
  
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    

    

    
    var perfumeList = [PerfumeData]()
    var searching = false
    var searchedperfume = [PerfumeData]()
    let searchController = UISearchController(searchResultsController: nil)
    var scopeButtonPressed = false
    var  ref = Firestore.firestore()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        MyCollectionView.dataSource = self
        MyCollectionView.delegate = self
        ref.collection("perfumes").getDocuments() {[weak self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let nam = document.data()["name"] as? String
                    let img = document.data()["image"] as? String
                    let prc = document.data()["price"] as? Double
                    let gender = document.data()["Gender"] as? String
                    let desc = document.data()["desc"] as? String
                    let doc = PerfumeData(pName: nam ?? "" , pImg: img  ?? "" , pPrice: prc  ?? 0 , pGender: gender ?? "", pDesc: desc  ?? "")
                    self?.perfumeList.append(doc)
                    self?.MyCollectionView.reloadData()
                    
                }
                   // print(nam ?? "" , img ?? "" , prc ?? 0 , gender ?? "")
                
            }
        }
        
    
    }
    
    private func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.scopeButtonTitles = ["All" , "Men" , "Women"]
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Perfume By Name"
        
    }
     
        
    
  

}
