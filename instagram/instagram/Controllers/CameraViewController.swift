//
//  CameraViewController.swift
//  instagram
//
//  Created by Beverly Abadines on 2/20/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

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
    
    
    override internal func viewDidLoad(){
        super.viewDidLoad()
    }
}
