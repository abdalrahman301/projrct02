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
        VCViewController?.imagerecieved = UIImage(named: searchedperfume[indexPath.row].PerfumeImage)!
            VCViewController?.namerecieved = ("\(searchedperfume[indexPath.row].perfumeName)")
            VCViewController?.pricerecieved = ("\(searchedperfume[indexPath.row].PerfumePrice) Jd")
        self.present((VCViewController)!, animated: true, completion: nil)
        }
        else {
             VCViewController?.imagerecieved = UIImage(named: perfumeList[indexPath.row].PerfumeImage)!
                       VCViewController?.namerecieved = ("\(perfumeList[indexPath.row].perfumeName)")
                       VCViewController?.pricerecieved = ("\(perfumeList[indexPath.row].PerfumePrice) Jd")
                   self.present((VCViewController)!, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    

    

    
    var perfumeList = [PerfumeData]()
    var searching = false
    var searchedperfume = [PerfumeData]()
    let searchController = UISearchController(searchResultsController: nil)
    var scopeButtonPressed = false
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        configureSearchController()
        MyCollectionView.dataSource = self
        MyCollectionView.delegate = self
        
     
        
        
    
    }
    func fillData () {
        let perfume1 = PerfumeData(pName: "Blue De Channel", pImg: "bluedechanel", pPrice: 60, pGender: "Men"  )
        perfumeList.append(perfume1)
        let perfume2 = PerfumeData(pName: "Creed Aventus", pImg: "creed", pPrice: 90, pGender: "Men")
        perfumeList.append(perfume2)
        
        let perfume3 = PerfumeData(pName: "Lacoste Pink", pImg: "pp", pPrice: 45, pGender: "Women")
        perfumeList.append(perfume3)
        let perfume4 = PerfumeData(pName: "Prada", pImg: "prada", pPrice: 52, pGender: "Women")
        perfumeList.append(perfume4)
        let perfume5 = PerfumeData(pName: "Montblanc", pImg: "montblanc", pPrice: 40, pGender: "Men")
        perfumeList.append(perfume5)
        let perfume6 = PerfumeData(pName: "Fahrenheit", pImg: "fahrenheit", pPrice: 45, pGender: "Men")
        perfumeList.append(perfume6)
        let perfume7 = PerfumeData(pName: "Prestige", pImg: "prestige", pPrice: 46, pGender: "Women")
        perfumeList.append(perfume7)
        let perfume8 = PerfumeData(pName: "Lacoste White", pImg: "lacostewhite", pPrice: 62, pGender: "Men")
        perfumeList.append(perfume8)
        let perfume9 = PerfumeData(pName: "Jadore", pImg: "jadore", pPrice: 60, pGender: "Women")
        perfumeList.append(perfume9)
        let perfume10 = PerfumeData(pName: "Blue", pImg: "bluemen", pPrice: 33 , pGender: "Men")
        perfumeList.append(perfume10)
        let perfume11 = PerfumeData(pName: "Shalis Men", pImg: "shlalismen", pPrice: 50 , pGender: "Men")
        perfumeList.append(perfume11)
        let perfume12 = PerfumeData(pName: "Shalis Women", pImg: "shaliswomen", pPrice: 50 , pGender: "Women")
        perfumeList.append(perfume12)
        let perfume13 = PerfumeData(pName: "Armani Si", pImg: "armanisi", pPrice: 52 , pGender: "Women")
        perfumeList.append(perfume13)
        let perfume14 = PerfumeData(pName: "Valentino", pImg: "valentino", pPrice: 43, pGender: "Women")
        perfumeList.append(perfume14)
        let perfume15 = PerfumeData(pName: "Mademoselle", pImg: "mademoselle", pPrice: 40 , pGender: "Women")
        perfumeList.append(perfume15)
        let perfume16 = PerfumeData(pName: "Versaci Bright", pImg: "versacibright", pPrice: 70 , pGender: "Women")
        perfumeList.append(perfume16)
        let perfume17 = PerfumeData(pName: "Allure", pImg: "allurehomme", pPrice: 60 , pGender: "Men")
        perfumeList.append(perfume17)
        let perfume18 = PerfumeData(pName: "LCW Wood", pImg: "lcwwood", pPrice: 40 , pGender: "Men")
        perfumeList.append(perfume18)
        let perfume19 = PerfumeData(pName: "Miss Dior", pImg: "missdior", pPrice: 40, pGender: "Women")
        perfumeList.append(perfume19)
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
