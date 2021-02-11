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
    
    //画像加工するための元となる画像
    var originalImage: UIImage!
    
    //画像加工するフィルターの宣言
    var filter: CIFilter!
    
    

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
            print("error")
        }
    }
    
    
    
    //写真撮影後、写真を表示したりアプリに戻る処理imagePickerControllerメソッド作成
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        cameraImageView.image = info[.editedImage] as? UIImage
        
        //写真撮影後、その画像を加工する前の元画像として記憶
        originalImage = cameraImageView.image
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //撮影した画像を保存するためのメソッド
    @IBAction func savePhoto(){
        
        //保存機能を持たせる
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
    }
    
    

    //表示している画像フィルターを加工する時のメソッド
    @IBAction func colorFilter(){
        
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        //フィルターの設定
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        //彩度の調整
        filter.setValue(1.0, forKey: "inputSaturation")
        
        //明度の調整
        filter.setValue(0.5, forKey: "inputBrightness")
        
        //コントラストの調整
        filter.setValue(2.5, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
    }
    
    
    
    //カメラロールにある画像を読み込む
    @IBAction func openAlubum(){
        
        //カメラロールを使えるかの確認
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            //カメラロールの画像を選択して画像を表示するまでの一連の流れ
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }
    }
    
    
    
    //SNSに編集した画像を投稿した時のメソッド
    @IBAction func snsPhoto(){
        
        //投稿する時に一緒に載せるコメント
        let shareText = "写真加工テンアゲ↑↑"
        
        //投稿する画像の選択
        let shareImage = cameraImageView.image!
        
        //投稿するコメントと画像の準備
        let activityItems: [Any] = [shareText, shareImage]
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        let excludedActivityTypes = [UIActivity.ActivityType.postToWeibo, .saveToCameraRoll, .print]
        
        activityViewController.excludedActivityTypes = excludedActivityTypes
        
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    

}

