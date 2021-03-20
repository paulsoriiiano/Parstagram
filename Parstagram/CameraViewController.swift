//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Paul Junver Soriano on 3/11/21.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
            post.saveInBackground{(success, error) in
                if (success){
                    self.dismiss(animated: true, completion: nil)
                    print("Posted")
                } else {
                    print("Error: \(String(describing: error))")
                }
            }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let clicker = UIImagePickerController()
        clicker.delegate = self
        clicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            clicker.sourceType = .camera
        } else {
            clicker.sourceType = .photoLibrary
        }
        
        present(clicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ clicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
