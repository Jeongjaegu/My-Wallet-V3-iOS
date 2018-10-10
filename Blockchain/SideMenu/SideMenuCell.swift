//
//  SideMenuCell.swift
//  Blockchain
//
//  Created by Chris Arriola on 8/17/18.
//  Copyright © 2018 Blockchain Luxembourg S.A. All rights reserved.
//

final class SideMenuCell: UITableViewCell {

    static let defaultHeight: CGFloat = 54, defaultTextLabelOffsetX: CGFloat = 55

    var item: SideMenuItem? {
        didSet {
            self.textLabel?.text = item?.title
            self.imageView?.image = item?.image
            setupBadgeIfNeeded()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.font = UIFont(name: Constants.FontNames.montserratRegular, size: Constants.FontSizes.Small)
        self.textLabel?.textColor = .gray5
        self.textLabel?.highlightedTextColor = .gray5
        self.imageView?.contentMode = .scaleAspectFill
    }

    private func setupBadgeIfNeeded() {
        if item == .lockbox, contentView.subviews.count == 2, let window = UIApplication.shared.keyWindow {
            let tabViewControllerPosX = AppCoordinator.shared.tabControllerManager.view.frame.origin.x
            let sideMenuCoverAmount = window.frame.size.width - tabViewControllerPosX
            let badgePadding: CGFloat = 8, badgeRightOffset: CGFloat = sideMenuCoverAmount + 32
            let badgeLabel = UILabel(frame: CGRect.zero)
            badgeLabel.text = LocalizationConstants.SideMenu.newItemBadgeTitle
            badgeLabel.textAlignment = .center
            badgeLabel.font = UIFont(name: Constants.FontNames.montserratMedium, size: Constants.FontSizes.ExtraExtraSmall)
            badgeLabel.textColor = .white
            badgeLabel.sizeToFit()
            let badgeFrameWidth: CGFloat = badgeLabel.frame.size.width + (2 * badgePadding), badgeFrameHeight: CGFloat = 24
            let badgeFramePosX = self.frame.size.width - badgeFrameWidth - badgeRightOffset
            let badgeFramePosY = (self.frame.size.height / 2) - (badgeFrameHeight / 2)
            let badgeFrame = CGRect(x: badgeFramePosX, y: badgeFramePosY, width: badgeFrameWidth, height: badgeFrameHeight)
            let badge = UIView(frame: badgeFrame)
            badge.backgroundColor = .brandSecondary
            badge.layer.cornerRadius = 4
            badge.addSubview(badgeLabel)
            contentView.addSubview(badge)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let imageView = self.imageView else { return }
        guard let textLabel = self.textLabel else { return }
        let imageViewSize: CGFloat = 21
        imageView.frame = CGRect(
            x: 15,
            y: ((frame.height / 2) - (imageViewSize / 2)),
            width: imageViewSize,
            height: imageViewSize
        )
        textLabel.frame = CGRect(
            x: SideMenuCell.defaultTextLabelOffsetX,
            y: textLabel.frame.minY,
            width: textLabel.frame.width,
            height: textLabel.frame.height
        )
    }
}
