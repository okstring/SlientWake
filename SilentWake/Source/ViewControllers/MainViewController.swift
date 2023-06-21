//
//  ViewController.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/05/03.
//

import UIKit
import AVFoundation

import ReactorKit
import RxSwift
import SnapKit

class MainViewController: BaseViewController, View {
    var player: AVAudioPlayer!

    var remainingTime = 0
    var isProgressingTimer = false

    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = GreetingsType.now.description
        label.font = .systemFont(ofSize: 38, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    let countDownLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()

    let timePickerViewController: TimePickerViewController = {
        let viewController = TimePickerViewController()
        viewController.theme = .dark
        return viewController
    }()

    let timePickerContainerView: UIView = {
        let view = UIView()
        return view
    }()

    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("start", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    init(reactor: MainReactor) {
      super.init()
      self.reactor = reactor
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()

        startButton.addTarget(self, action: #selector(tapStartButton(_:)), for: .touchUpInside)

        guard let url = Bundle.main.url(forResource: "Alarm1", withExtension: "mp3") else {
            return
        }

        player = try! AVAudioPlayer(contentsOf: url)
        player.prepareToPlay()
        player.volume = 0.5
        player.numberOfLoops = -1
        player.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            print(self.player.isPlaying)
            self.player.volume = 1.0
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        headerLabel.text = GreetingsType.now.description
    }

    func setUI() {
        view.addSubview(headerLabel)

        headerLabel.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.equalTo(view).offset(16)
        })

        view.addSubview(timePickerContainerView)

        addChild(timePickerViewController)
        timePickerViewController.didMove(toParent: self)
        timePickerContainerView.addSubview(timePickerViewController.view)

        view.addSubview(countDownLabel)
        view.addSubview(startButton)

        timePickerContainerView.snp.makeConstraints({
            $0.width.height.equalTo(timePickerViewController.contentsViewSize)
            $0.center.equalTo(view.safeAreaLayoutGuide.snp.center)
        })

        countDownLabel.snp.makeConstraints({
            $0.top.equalTo(timePickerContainerView.snp.bottom).offset(16)
            $0.centerX.equalTo(view.snp.centerX)
        })

        startButton.snp.makeConstraints({
            $0.top.equalTo(countDownLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(view.snp.centerX)
        })
    }

    @objc func tapStartButton(_ sender: Any) {
//        remainingTime = Int(countDownPicker.countDownDuration)
        print(timePickerViewController.result.date)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.remainingTime -= 1
            self.countDownLabel.text = "\(self.remainingTime)"

            if self.remainingTime == 0 {
                timer.invalidate()
            }
        }
    }

    func bind(reactor: MainReactor) {

    }
}

