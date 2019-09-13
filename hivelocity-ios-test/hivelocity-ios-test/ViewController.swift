//
//  ViewController.swift
//  hivelocity-ios-test
//
//  Created by takanobu sugiyama on 2019/08/05.
//

import UIKit

class ViewController: UIViewController {

    enum ScreenState {
        case loading
        case loaded
        case error(Error)
    }

    var state: ScreenState? = .loading {
        didSet {
            OperationQueue.main.addOperation { [weak self] in

                guard let strongSelf = self else { return }
                
                switch strongSelf.state! {
                    case .loading:
                        strongSelf.indicator.startAnimating()
                        strongSelf.tableView.isHidden = true
                        strongSelf.errorLabel.isHidden = true
                    case .loaded:
                        strongSelf.indicator.stopAnimating()
                        strongSelf.tableView.isHidden = false
                        strongSelf.tableView.reloadData()
                        strongSelf.errorLabel.isHidden = true
                    case .error(let error):
                        strongSelf.indicator.stopAnimating()
                        strongSelf.tableView.isHidden = true
                        strongSelf.errorLabel.isHidden = false
                        strongSelf.errorLabel.text = error.localizedDescription
                }
            }
        }
    }

    var todos: [Todo] = []

    let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        return table
    }()

    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    let errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let todo = "my new todo"

        view.addSubview(indicator)
        indicator.centerInSuperview()

        view.addSubview(tableView)
        tableView.fitToSuperview()

        view.addSubview(errorLabel)
        errorLabel.fitToSuperview()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TodoCell.self, forCellReuseIdentifier: "todocell")
        tableView.dataSource = self
        tableView.delegate = self

        load()
    }

    private func load() {
        state = .loading
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.state = .error(error)
                return
            }

            do {
                let todos = try JSONDecoder().decode(TodoResponse.self, from: data!)
                self.todos = todos
                self.state = .loaded
            } catch let decodingError {
                self.state = .error(decodingError)
            }
        }

        // to simulate asynchronous request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            task.resume()
        }
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state! {
        case .loaded:
            return todos.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = todos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todocell", for: indexPath) as! TodoCell
        cell.data = ("\(data.id!)", data.title!, data.completed!)
        return cell
    }

}

extension ViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let todoViewController = TodoViewController()
        present(todoViewController, animated: true)
    }

}




// MARK: - extensions

extension UIView {

    func fitToSuperview() {
        guard let superview = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                topAnchor.constraint(equalTo: superview.topAnchor),
                leftAnchor.constraint(equalTo: superview.leftAnchor),
                rightAnchor.constraint(equalTo: superview.rightAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            ]
        )
    }

    func centerInSuperview() {
        guard let superview = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            ]
        )
    }

}
