//
//  ViewController.swift
//  zadanie1
//
//  Created by Adrianna Ryś on 05.11.2016.
//  Copyright © 2016 ada. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var authorInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var ratingValue: UILabel!
    @IBOutlet weak var ratingStepper: UIStepper!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonRemove: UIButton!
    
    var albums: NSMutableArray? = AlbumsSingleton.sharedInstance.list
    var albumIndex: Int = 0
    var showNewAlbum = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSave.isEnabled = false
        ratingStepper.maximumValue = 5
        
        if showNewAlbum == true {
            buttonAddClicked(buttonAdd)
            showNewAlbum = false
        } else {
            loadAlbum()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setRating(ratingValue: Int?) {
       
        if ratingValue != nil && ratingValue! >= 0 && ratingValue! <= 5 {
            self.ratingValue.text = String(ratingValue!)
        }
    }
    
    func loadAlbum() {
        let album = albums?.object(at: albumIndex) as! [String:Any]!
        let artist = album!["artist"]!
        let title = album!["title"]!
        let genre = album!["genre"]!
        let date = album!["date"]!
        let rating = album!["rating"]!
    
        authorInput.text = "\(artist)"
        nameInput.text = "\(title)"
        genreField.text = "\(genre)"
        yearField.text = "\(date)"
        ratingValue.text = "\(rating)"
    }
    
    func clearInputs(){
        authorInput.text = ""
        nameInput.text = ""
        genreField.text = ""
        yearField.text = ""
        ratingValue.text = "0"
    }
    
    @IBAction func ratingStepperClicked(_ sender: UIStepper){
       self.setRating(ratingValue: Int(sender.value));
    }
    
    func addNewAlbum(albumIndex: Int){
        let albumData = NSMutableDictionary()
         albumData.setObject(authorInput.text as Any , forKey: "artist" as NSCopying)
         albumData.setObject(nameInput.text as Any , forKey: "title" as NSCopying)
         albumData.setObject(yearField.text as Any , forKey: "date" as NSCopying)
         albumData.setObject(genreField.text as Any , forKey: "genre" as NSCopying)
         albumData.setObject(ratingValue.text as Any , forKey: "rating" as NSCopying)
        
        albums?.add(albumData)
    }

    @IBAction func buttonNextClicked(_ sender: UIButton) {
        albumIndex = albumIndex + 1;
        buttonSave.isEnabled = false
        let albumsCount = albums!.count
        print(albumsCount, albumIndex)
        
        if albumsCount == albumIndex {
            clearInputs()
            buttonRemove.isEnabled = false
            
        } else {
            loadAlbum()
            buttonRemove.isEnabled = true
        }
    }
    
    @IBAction func buttonPrevClicked(_ sender: UIButton) {
        albumIndex = albumIndex - 1;
        buttonSave.isEnabled = false
        buttonRemove.isEnabled = true
        
        if albums!.count > albumIndex {
            loadAlbum()
        }
    }
    
    func loadNewRecord() {
        let index = albums?.count
        let album = albums?.object(at: index! - 1) as! [String:Any]!
        let artist = album!["artist"]!
        let title = album!["title"]!
        let genre = album!["genre"]!
        let date = album!["date"]!
        let rating = album!["rating"]!
        
        authorInput.text = "\(artist)"
        nameInput.text = "\(title)"
        genreField.text = "\(genre)"
        yearField.text = "\(date)"
        ratingValue.text = "\(rating)"
        albumIndex = albums!.count - 1
    }
    

    @IBAction func buttonSaveClicked(_ sender:UIButton) {
        print(albumIndex)
        addNewAlbum(albumIndex: albums!.count - 1 );
        buttonSave.isEnabled = false
        loadNewRecord()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonAddClicked(_ sender: Any?) {
        clearInputs()
    }
    
    @IBAction func buttonRemoveClicked(_ sender: UIButton) {
        albums?.removeObject(at: albumIndex)
        
        if albums!.count > albumIndex {
            loadAlbum()
        }
        else {
            clearInputs()
            buttonRemove.isEnabled = false
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnReturnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func authorValueChanged(_ sender: UITextField) {
        buttonSave.isEnabled = true
    }
    @IBAction func yearValueChanged(_ sender: UITextField) {
        buttonSave.isEnabled = true
    }
    @IBAction func titleValueChanged(_ sender: UITextField) {
        buttonSave.isEnabled = true
    }
    @IBAction func ratingValueChanged(_ sender: UIStepper) {
        buttonSave.isEnabled = true
    }
    @IBAction func genreValueChanged(_ sender: UITextField) {
        buttonSave.isEnabled = true
    }

}

