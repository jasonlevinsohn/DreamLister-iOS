//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by jlev on 7/18/17.
//  Copyright © 2017 L3. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleTxt: CustomTextField!
    @IBOutlet weak var priceTxt: CustomTextField!
    @IBOutlet weak var detailsTxt: CustomTextField!
    
    var stores = [Store]()
    var itemToEdit: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
//        let store1 = Store(context: context)
//        store1.name = "Tractor Supply"
//        let store2 = Store(context: context)
//        store2.name = "Amazon"
//        let store3 = Store(context: context)
//        store3.name = "Egg Washing Company"
//        let store4 = Store(context: context)
//        store4.name = "Best Buy"
//        let store5 = Store(context: context)
//        store5.name = "K Mart"
//        let store6 = Store(context: context)
//        store6.name = "Blockbuster"
//        
//        ad.saveContext()
        getStores()
        
        if itemToEdit != nil {
            
            loadItemData()
            
        }



        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            // Handle the error
        }
    }
    @IBAction func saveItem(_ sender: UIButton) {
        
        var item: Item!
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        if let title = titleTxt.text {
            item.title = title
        }
        
        if let price = priceTxt.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsTxt.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)
        
        
        
        
        
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            titleTxt.text = item.title
            priceTxt.text = "\(item.price)"
            detailsTxt.text = item.details
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        
                        
                        
                        storePicker.selectRow(index, inComponent: 0,
                            animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
        }
        
    }
    
    
    
    
    
    
   
}
