//
//  ViewController.swift
//  lab9
//
//  Created by lucas on 6/05/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var PickerView: UITableView!

  
    @IBOutlet weak var tableView: UITableView!
    var juegos : [Juego] = []
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try juegos = context.fetch(Juego.fetchRequest())
            tableView.reloadData()
        }catch{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        PickerView.delegate = self
        PickerView.dataSource = self
        
        // Do any additional setup after loading the view.
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        
        if let imageData = juego.imagen {
             cell.imageView?.image = UIImage(data: imageData)
         }
         
         return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
            // Aquí colocas el código para eliminar el juego seleccionado de inmediato
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = self.juegos[indexPath.row]
            context.delete(juego)
            do {
                try context.save()
                self.juegos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Error al eliminar el juego: \(error.localizedDescription)")
            }
        }
        
        let editAction = UITableViewRowAction(style: .default, title: "Editar") { (action, indexPath) in
            let juego = self.juegos[indexPath.row]
            self.performSegue(withIdentifier: "juegoSegue", sender: juego)
        }
        
        return [deleteAction, editAction]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
       
            let juegoSeleccionado = juegos[indexPath.row]
            juegos.remove(at: indexPath.row)
            juegos.insert(juegoSeleccionado, at: max(indexPath.row - 1, 0))
            tableView.reloadData()
        } else {
    
            let juego = juegos[indexPath.row]
            performSegue(withIdentifier: "juegoSegue", sender: juego)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "juegoSegue" {
            // Si el segue es para JuegosViewController, realizar la preparación necesaria
            let siguienteVC = segue.destination as! JuegosViewController
            siguienteVC.juego = sender as? Juego
        } else if segue.identifier == "categoria" {
            let siguienteVC = segue.destination as! ViewController2
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let juegoMovido = juegos.remove(at: sourceIndexPath.row)
        juegos.insert(juegoMovido, at: destinationIndexPath.row)
    }

}

