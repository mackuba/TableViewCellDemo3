//
//  TweetCell.swift
//  TableViewCellDemo3
//
//  Created by Kuba Suder on 04/02/2023.
//

import Cocoa

class ImageWrapper: NSView {
    let imageView: NSImageView

    var image: NSImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    init(_ imageView: NSImageView) {
        self.imageView = imageView
        super.init(frame: .zero)
        addSubview(imageView)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layout() {
        super.layout()

        let width = imageView.image!.size.width
        let height = imageView.image!.size.height

        let maxWidth = self.bounds.width
        let maxHeight = self.bounds.height

        let scale = min(maxWidth / width, maxHeight / height)

        imageView.frame = CGRect(
            x: 0.0,
            y: 0.0,
            width: width * scale,
            height: height * scale
        )
    }
}

class TweetCell: NSTableCellView {
    static let identifier = NSUserInterfaceItemIdentifier("TweetCell")

    var photoView: NSImageView!
    var aspectRatioConstraint: NSLayoutConstraint?

    override var isFlipped: Bool {
        return true
    }

    init() {
        super.init(frame: .zero)

        self.wantsLayer = true
        self.layer!.borderColor = NSColor.red.cgColor
        self.layer!.borderWidth = 1.0

        let textField = NSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isBordered = false
        textField.isEditable = false
        textField.isSelectable = true
        textField.backgroundColor = nil
        textField.font = NSFont.systemFont(ofSize: NSFont.systemFontSize)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.backgroundColor = NSColor(calibratedRed: 0.0, green: 1.0, blue: 0.0, alpha: 0.1)
        textField.stringValue = "This is a photo taken in Krakow in December before Christmas, when there were a few very snowy days and it was so white and lovely"
        addSubview(textField)

        addConstraints([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
        ])

        let photoView = NSImageView()
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.imageScaling = .scaleProportionallyUpOrDown
        photoView.wantsLayer = true
        photoView.layer!.cornerRadius = 10.0
        photoView.layer!.masksToBounds = true
        photoView.layer!.borderColor = NSColor(calibratedRed: 1.0, green: 0.0, blue: 1.0, alpha: 1.0).cgColor
        photoView.layer!.borderWidth = 1.0

        let wrapper =
//            ImageWrapper(photoView)
            photoView

        addSubview(wrapper)
        self.photoView = wrapper

        addConstraints([
            wrapper.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            wrapper.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            wrapper.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10.0),
            wrapper.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override var objectValue: Any? {
        didSet {
            if let constraint = aspectRatioConstraint {
                self.removeConstraint(constraint)
            }

            if let name = self.objectValue as? String {
                let image = NSImage(named: name)!
                self.photoView.image = image

                let width = image.size.width
                let height = image.size.height
                let aspectRatio = width / height

                let constraint = photoView.widthAnchor.constraint(
                    equalTo: photoView.heightAnchor,
                    multiplier: aspectRatio
                )
//                constraint.priority = NSLayoutConstraint.Priority(450.0)
                self.addConstraint(constraint)
                self.aspectRatioConstraint = constraint
            } else {
                self.photoView.image = nil
                self.aspectRatioConstraint = nil
            }
        }
    }
}
