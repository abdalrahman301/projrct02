//
//  HomeViewController.swift
//  projrct
//
//  Created by htu on 7/28/22.
//  Copyright © 2022 htu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate , UICollectionViewDataSource , UISearchResultsUpdating , UISearchBarDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return searchedperfume.count
        }else {
            return perfumeList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! MyCollectionViewCell
        if searching {
            cell.productimg.image = UIImage(named:searchedperfume[indexPath.row].PerfumeImage)
            cell.productname.text = searchedperfume[indexPath.row].perfumeName
            
            cell.price.text = searchedperfume[indexPath.row].PerfumePrice
            
        }else {
            
              cell.productimg.image = UIImage(named:perfumeList[indexPath.row].PerfumeImage)
                      cell.productname.text = perfumeList[indexPath.row].perfumeName
                      
                      cell.price.text = perfumeList[indexPath.row].PerfumePrice
                      
            
        }
        return cell
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            searchedperfume.removeAll()
        
        for perfume in perfumeList {
            if perfume.perfumeName.lowercased().contains(searchText.lowercased())
            {
        searchedperfume.append(perfume)
            }}}
        else {
            searching = false
            searchedperfume.removeAll()
            searchedperfume = perfumeList
            
        }
        MyCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedperfume.removeAll()
        MyCollectionView.reloadData()
    }
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    var perfumeList = [PerfumeData]()
    var searching = false
    var searchedperfume = [PerfumeData]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        configureSearchController()
        MyCollectionView.dataSource = self
        MyCollectionView.delegate = self
    
    }
    func fillData () {
        let perfume1 = PerfumeData(pName: "Blue De Channel", pImg: "bluede", pPrice: "60$")
        perfumeList.append(perfume1)
        let perfume2 = PerfumeData(pName: "Creed Aventus", pImg: "creed", pPrice: "90$")
        perfumeList.append(perfume2)
        
        let perfume3 = PerfumeData(pName: "Lacoste Pink", pImg: "pp", pPrice: "45$")
        perfumeList.append(perfume3)
        
    }
    private func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Perfume By Name"
    }
     
        
    
  

}
