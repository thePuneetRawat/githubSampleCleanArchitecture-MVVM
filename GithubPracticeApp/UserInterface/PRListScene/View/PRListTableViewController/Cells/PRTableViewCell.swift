//
//  PRTableViewCell.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 08/05/22.
//

import UIKit

class PRTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PRTableViewCell.self)
    static let height = CGFloat(150)
    @IBOutlet weak var avatarImgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var createdByLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var closeAtLabel: UILabel!
    private var viewModel: PullRequestViewModel!
    private var imageFetchManager: ImageRequestFetchManager?
    private var imageLoadTask: Cancellable? {willSet {imageLoadTask?.cancel()}}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        resetCell()
    }
    
    override func prepareForReuse() {
        resetCell()
    }
    
    private func resetCell() {
        avatarImgView.image = nil
        titleLabel.text = ""
        createdAtLabel.text = ""
        closeAtLabel.text = ""
        createdByLabel.text = ""
    }
    
    
    func setupCell(with viewModel: PullRequestViewModel, imageFetchManager: ImageRequestFetchManager?) {
        self.viewModel = viewModel
        self.imageFetchManager = imageFetchManager
        createdByLabel.text = viewModel.username
        titleLabel.text = viewModel.title
        if let created = viewModel.createdAt {
            createdAtLabel.text = "Created at - " + created
        }
        if let closed = viewModel.closedAt {
            closeAtLabel.text = "Closed at - " + closed
        }
        updateAvatarImage()
    }
    
    private func updateAvatarImage() {
        avatarImgView.image = nil
        if let userImagePath = viewModel.userImg{
            imageLoadTask = imageFetchManager?.fetchImage(with: userImagePath) { [weak self] result in
                guard let self = self else { return }
                guard self.viewModel.userImg == userImagePath else { return }
                if case let .success(data) = result {
                    self.avatarImgView.image = UIImage(data: data)
                }
                self.imageLoadTask = nil
            }
        }
    }

}
