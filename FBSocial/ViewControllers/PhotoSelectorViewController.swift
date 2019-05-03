//
//  PhotoSelectorViewController.swift
//  FBSocial
//
//  Created by Ben Huggins on 5/3/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class PhotoSelectorViewController: UIViewController {
    
    @IBOutlet weak var  selectedPhotoButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    weak var delegate: PhotoSelectorViewControllerDelegate?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photoImageView.image = nil
        selectedPhotoButton.setTitle("Select a Photo to Post", for: .normal)
    }
    @IBAction func selectedPhotoButtonTapped(_ sender: UIButton){
        presentImagePickerActionSheet()
    }
}//End of Class

//MARK: - Extensions
extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedPhotoButton.setTitle("", for: .normal)
            photoImageView.image = photo
            delegate?.photoSelectorViewControllerSelected(image: photo)
        }
    }//End of Func
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }//End of Func
    func presentImagePickerActionSheet(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            actionSheet.addAction(UIAlertAction(title: "Photo", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        //    if UIImagePickerController.isSourceTypeAvailable(.camera){
        //      actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
        //        imagePickerController.sourceType = UIImagePickerController.SourceType.camera
        //        self.present(imagePickerController, animated: true, completion: nil)
        //      }))
        //    }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
}//End of Extension

//MARK: -Protocol
protocol PhotoSelectorViewControllerDelegate: class {
    func photoSelectorViewControllerSelected(image: UIImage)
}
