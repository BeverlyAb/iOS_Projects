//
//  CameraViewController.swift
//  instagram
//
//  Created by Beverly Abadines on 2/20/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import AlamofireImage

internal class CameraViewController : UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func onSubmitButton(_ sender: Any) {
    }
    
    @IBAction func onShootButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        //resize
        let size = CGSize(width:300, height:300)
        let scaledImg = image.af_imageScaled(to:size)
        
        imageView.image = scaledImg
        dismiss(animated: true, completion: nil)
    }
    
    override internal func viewDidLoad(){
        super.viewDidLoad()
    }
}
