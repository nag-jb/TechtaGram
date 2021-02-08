//
//  ViewController.swift
//  TechtaGram
//
//  Created by Sallivan James on 2021/02/08.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //画像を表示するUIImageViewの宣言
    @IBOutlet var cameraImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //撮影するボタンを押した時のメソッド
    @IBAction func takePhoto(){
        
        //カメラが使えるのか確認
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            //カメラを起動
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }else{
            //カメラを使えない時はエラーがコンソールに出る。
        }print("error")
    }
    
    //撮影した画像を保存するためのメソッド
    @IBAction func savePhoto(){
        
    }

    //表示している画像フィルターを加工する時のメソッド
    @IBAction func colorFilter(){
        
    }
    
    //カメラロールにある画像を読み込む
    @IBAction func openAlubum(){
        
    }
    
    //SNSに編集した画像を投稿した時のメソッド
    @IBAction func snsPhoto(){
        
    }
    
    

}

