//
//  GoalTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 06.01.2022.
//

import UIKit

protocol GoalTableViewCellDelegate: AnyObject {
    var goalData: GoalData { get set }
    func updateHeightOfRow(_ cell: GoalTableViewCell, _ textView: UITextView)
}

final class GoalTableViewCell: UITableViewCell {
    
    static let identifier = "goalTableViewCell"
    
    private let labelsArray = [Labels.Agenda.currentLabel, Labels.Agenda.aimLabel]
    public var goal: GoalData? // to fill the cell with data (from GoalDetails)
    public weak var delegate: GoalTableViewCellDelegate?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var titleTextField = UITextField(keyboardType: .default, placeholder: Labels.Agenda.titleLabel, textAlignment: .left, borderStyle: .none)
    private lazy var currentTextField = UITextField(keyboardType: .numberPad, placeholder: "0", borderStyle: .roundedRect)
    private lazy var aimTextField = UITextField(keyboardType: .numberPad, placeholder: "0", borderStyle: .roundedRect)
    
    private lazy var notesTextView: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = Labels.Agenda.notes
        textView.backgroundColor = .clear
        textView.textColor = .placeholderText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.resignFirstResponder()
        textView.accessibilityIdentifier = "notesTextView"
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        accessibilityIdentifier = "GoalTableViewCell"
        titleTextField.accessibilityIdentifier = "titleTextField"
        currentTextField.accessibilityIdentifier = "currentTextField"
        aimTextField.accessibilityIdentifier = "aimTextField"
        
        contentView.addSubview(label)
        contentView.addSubview(titleTextField)
        titleTextField.clearButtonMode = .whileEditing
        titleTextField.addTarget(self, action: #selector(titleTextFieldChange), for: .allEditingEvents)
        contentView.addSubview(notesTextView)
        
        contentView.addSubview(currentTextField)
        currentTextField.addTarget(self, action: #selector(currentTextFieldChange), for: .allEditingEvents)
        contentView.addSubview(aimTextField)
        aimTextField.addTarget(self, action: #selector(aimTextFieldChange), for: .allEditingEvents)
        
        [titleTextField, currentTextField, aimTextField].forEach {
            $0.delegate = self
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleTextField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            notesTextView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: -4),
            notesTextView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            notesTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            notesTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            currentTextField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            currentTextField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            currentTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            aimTextField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            aimTextField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            aimTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func configure(indexPath: IndexPath) {
        if indexPath == [0, 0] {
            titleTextField.isHidden = false
            titleTextField.text = goal?.title
        }
        if indexPath == [0, 1] {
            notesTextView.isHidden = false
            
            if let notes = goal?.notes, notes != Labels.Agenda.notes, !notes.isEmpty {
                notesTextView.text = notes
                notesTextView.textColor = .label
            }
        }
        if indexPath == [1, 0] {
            currentTextField.isHidden = false
            currentTextField.text = goal?.current
            label.isHidden = false
            label.text = labelsArray[indexPath.row]
        }
        if indexPath == [1, 1] {
            aimTextField.isHidden = false
            aimTextField.text = goal?.aim
            label.isHidden = false
            label.text = labelsArray[indexPath.row]
        }
    }
}

// MARK: - UITextFieldDelegate & Text Fields' methods to transfer data and
extension GoalTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // limiting input to 120 symbols
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 120
    }
    
    @objc private func titleTextFieldChange(_ sender: UITextField) {
        delegate?.goalData.title = sender.text ?? ""
    }
    
    @objc private func currentTextFieldChange(_ sender: UITextField) {
        delegate?.goalData.current = sender.text ?? ""
    }
    
    @objc private func aimTextFieldChange(_ sender: UITextField) {
        delegate?.goalData.aim = sender.text ?? ""
    }
}

// MARK: - UITextViewDelegate
extension GoalTableViewCell: UITextViewDelegate {
    // adding dynamic height to the TextView and provide data
    func textViewDidChange(_ textView: UITextView) {
        if let deletate = delegate {
            deletate.updateHeightOfRow(self, textView)
            deletate.goalData.notes = textView.text ?? ""
        }
    }
    
    // adding placeholder to the TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Labels.Agenda.notes
            textView.textColor = .placeholderText
        }
    }
}
