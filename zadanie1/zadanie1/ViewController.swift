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
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonPrev: UIButton!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonRemove: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusLabelMax: UILabel!
    
    var albums: NSMutableArray?
    var albumIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSave.isEnabled = false
        buttonPrev.isEnabled = false
        ratingStepper.maximumValue = 5;
        
        let plistCatPath = Bundle.main.path(forResource: "albums", ofType: "plist")
        albums = NSMutableArray(contentsOfFile:plistCatPath!)
        setStatus()
        

        loadAlbum()
        
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
    
    func setStatus() {
        statusLabel.text = "\(albumIndex + 1)"
        statusLabelMax.text = "\(albums!.count)"
    }
    
    func clearInputs(){
        authorInput.text = nil
        nameInput.text = nil
        genreField.text = nil
        yearField.text = nil
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
        buttonPrev.isEnabled = true
        let albumsCount = albums!.count
        print(albumsCount, albumIndex)
        
        if albumsCount == albumIndex {
            clearInputs()
            print("count = index")
            buttonNext.isEnabled = false
            buttonRemove.isEnabled = false
            statusLabel.text = "new"
            
        } else {
            setStatus()
            loadAlbum()
            buttonRemove.isEnabled = true
        }
    }
    
    @IBAction func buttonPrevClicked(_ sender: UIButton) {
        albumIndex = albumIndex - 1;
        buttonSave.isEnabled = false
        buttonNext.isEnabled = true
        buttonRemove.isEnabled = true
        
        if albums!.count > albumIndex {
            if albumIndex == 0 {
                buttonPrev.isEnabled = false
            }
            
            loadAlbum()
            setStatus()
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
        statusLabelMax.text = "\(albums!.count)"
        albumIndex = albums!.count - 1
        statusLabel.text = "\(albums!.count)"

    }
    

    @IBAction func buttonSaveClicked(_ sender:UIButton) {
        print(albumIndex)
        addNewAlbum(albumIndex: albums!.count - 1 );
        buttonNext.isEnabled = true
        buttonPrev.isEnabled = true
        buttonSave.isEnabled = false
        print(albums!)
        loadNewRecord()
        print(albums!.count, albumIndex)
    }
    
    @IBAction func buttonAddClicked(_ sender: UIButton) {
        clearInputs()
        statusLabel.text = "new"
        statusLabelMax.text = "\(albums!.count + 1)"
        buttonPrev.isEnabled = true
        print(albumIndex)
    }
    
    @IBAction func buttonRemoveClicked(_ sender: UIButton) {
        print(albumIndex)
        albums?.removeObject(at: albumIndex)
        
        if albums!.count > albumIndex {
            loadAlbum()
            setStatus()
        }
        else {
            clearInputs()
            buttonRemove.isEnabled = false
        }
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

