//
//  LockboxViewController.swift
//  Blockchain
//
//  Created by Maurice A. on 10/10/18.
//  Copyright © 2018 Blockchain Luxembourg S.A. All rights reserved.
//

import UIKit

class LockboxViewController: UIViewController {

    // MARK: Private Properties

    private var lockboxIsAvailable: Bool {
        return LockboxRepository().lockboxes().count == 0
    }

    // MARK: - IBOutlets

    @IBOutlet private var mainCardView: UIView!
    @IBOutlet private var mainCardTitleLabel: UILabel!
    @IBOutlet private var mainCardDescriptionLabel: UILabel!
    @IBOutlet private var mainCardImageView: UIImageView!
    @IBOutlet private var mainCardButton: UIButton!
    
    @IBOutlet private var announcementCardView: UIView!
    @IBOutlet private var announcementCardTitleLabel: UILabel!
    @IBOutlet private var announcementCardDescriptionLabel: UILabel!
    @IBOutlet private var announcementCardImageView: UIImageView!

    @IBOutlet private var learnMoreLabel: UILabel!

    // MARK: - IBActions

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction private func mainCardButtonTapped(_ sender: Any) {
        if lockboxIsAvailable {
            // TODO: implement
        } else {
            // TODO: implement
        }
    }

    // View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addShadow(to: mainCardView.layer)

        mainCardButton.layer.cornerRadius = 4

        if lockboxIsAvailable {
            mainCardTitleLabel.text = "Get Your Lockbox"
            mainCardDescriptionLabel.text = "Safely store your crypto currency offline."
            mainCardImageView.image = #imageLiteral(resourceName: "Image-LockboxDevice")
            mainCardButton.setTitle("Buy Now for $99", for: .normal)

            addShadow(to: announcementCardView.layer)
            announcementCardTitleLabel.text = "Already own one?"
            announcementCardDescriptionLabel.text = "From your computer log into blockchain.com and connect your Lockbox."
            announcementCardDescriptionLabel.sizeToFit()
        } else {
            mainCardTitleLabel.text = "Balances Coming Soon"
            mainCardTitleLabel.text = """
                We are unable to display your Lockbox balance at this time.
                Don’t worry, your funds are safe. We’ll be adding this feature soon.
                While you wait, you can check your balance on the web.
            """
            mainCardImageView.image = #imageLiteral(resourceName: "Image-WebDashboard")
            mainCardButton.setTitle("Check My Balance", for: .normal)
            announcementCardView.isHidden = true
        }
    }

    private func addShadow(to cardLayer: CALayer) {
        cardLayer.cornerRadius = 4
        cardLayer.backgroundColor = UIColor.white.cgColor
        cardLayer.shadowOffset = CGSize(width: 0, height: 2)
        cardLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cardLayer.shadowOpacity = 1
        cardLayer.shadowRadius = 4
    }
}
