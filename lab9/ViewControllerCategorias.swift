import UIKit
import CoreData

class ViewControllerCategorias: UITableViewController {

    // Referencia al contexto de Core Data
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var descripcionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func agregarCategoria(_ sender: Any) {
        guard let nombre = nombreTextField.text, !nombre.isEmpty else {
            // Manejar el caso donde el campo de nombre está vacío
            return
        }
        
        let nuevaCategoria = Categoria(context: contexto)
        nuevaCategoria.nombre = nombre
        nuevaCategoria.descripcion = descripcionTextField.text
        
        // Guardar el contexto de Core Data
        do {
            try contexto.save()
            print("Nueva categoría agregada exitosamente")
            dismiss(animated: true, completion: nil) // Cerrar el ViewControllerCategorias después de agregar la categoría
        } catch {
            print("Error al agregar la nueva categoría: \(error)")
        }
    }

}

