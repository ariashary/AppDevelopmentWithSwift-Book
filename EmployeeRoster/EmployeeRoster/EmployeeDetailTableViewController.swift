
import UIKit

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeDelegate {

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    var employee: Employee?
    var employeeType: EmployeeType?
    
    var isEditingBirthday: Bool = false {
        didSet {
            dobDatePicker.isHidden = !isEditingBirthday
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return isEditingBirthday ? dobDatePicker.frame.height : 0.0
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            isEditingBirthday = !isEditingBirthday
            
            dobLabel.textColor = .black
            dobLabel.text = formatDate(date: dobDatePicker.date)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text, let type = employeeType {
            employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: type)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        dobLabel.text = formatDate(date: dobDatePicker.date)
    }
    
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    // MARK: - Employee Type Delegate
    
    func didSelect(employeeType: EmployeeType) {
        self.employeeType = employeeType
        employeeTypeLabel.textColor = .black
        employeeTypeLabel.text = employeeType.description()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let employeeTypeTableViewController = segue.destination as? EmployeeTypeTableViewController else { return }
        
        employeeTypeTableViewController.delegate = self
        employeeTypeTableViewController.employeeType = employeeType
    }

}
