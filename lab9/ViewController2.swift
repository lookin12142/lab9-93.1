import UIKit
import CoreData

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var TableView: UITableView!
    
let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var categorias: [Categoria] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        TableView.delegate = self
        TableView.dataSource = self
        
        cargarCategorias()
    }
    
    func cargarCategorias() {
        do {
            categorias = try contexto.fetch(Categoria.fetchRequest())
            TableView.reloadData()
        } catch {
            print("Error al cargar las categorías: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let categoria = categorias[indexPath.row]
        cell.textLabel?.text = categoria.nombre
        cell.detailTextLabel?.text = categoria.descripcion
        return cell
    }

}

