//
//  ViewController.swift
//  TareaPeticion
//
//  Created by XrgerX on 27/08/16.
//  Copyright © 2016 XrgerX. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var resultado: UITextView!
    @IBOutlet weak var isbn: UITextField!
    var textoresultado: String = ""
    var urlstable: String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    override func viewDidLoad() {
        super.viewDidLoad()
        isbn.delegate = self
        isbn.keyboardType = UIKeyboardType.WebSearch
        resultado.textColor = UIColor.blueColor()
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField){
       sender.resignFirstResponder()
    }
    
    func sincrono() {
        let urls = String(urlstable) + isbn.text!
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOfURL: url!)
        if datos == nil {
         let alerta = UIAlertController(title: "Sin Conexion", message: "No se pudo conectar con el Servidor", preferredStyle: .Alert)
         let accionError = UIAlertAction(title: "Error", style: .Default, handler: {
          accion in //..
          })
         alerta.addAction(accionError)
         self.presentViewController(alerta, animated: true, completion: nil)
        }
        else{
            let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
            self.textoresultado = String(texto!)
            if self.textoresultado == "{}" {
                self.textoresultado = "EL ISBN NO HA SIDO ENCONTRADO"
            }
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        isbn.text = textField.text!
        sincrono()
        resultado.text = textoresultado
        return true
    }
    
    @IBAction func textFieldDidBeginEditing(textField: UITextField){
      //textField.resignFirstResponder()
    }
    
    @IBAction func textFieldDidEndEditing(textField: UITextField) {
      //textField.resignFirstResponder()
    }
    
    @IBAction func limpiar() {
        isbn.text = ""
        resultado.text = ""
    }
}

