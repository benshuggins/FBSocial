//
//  FBPostTableViewController.swift
//  FBSocial
//
//  Created by Ben Huggins on 5/3/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Photos

class FBPostTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var captionTextField: UITextField!
    
    var selectedImage: UIImage?
    var fbPost: [FBPost]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.delegate = self
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selectedImage = nil
        captionTextField.text = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFBphotoSelectorVC" {
            let photoSelector = segue.destination as? PhotoSelectorViewController
            photoSelector?.delegate = self
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func postToFBbuttonTapped(_ sender: UIButton) {
        guard let crPhoto = selectedImage,
            let caption = captionTextField.text,
            !caption.isEmpty else {
                return
        }
        fbPost = FBPostController.shared.createPost(caption: caption, crPhoto: crPhoto)
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension FBPostTableViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        captionTextField.resignFirstResponder()
        selectedImage = image
    }
}
