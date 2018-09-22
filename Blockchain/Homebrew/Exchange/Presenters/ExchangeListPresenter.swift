//
//  ExchangeListPresenter.swift
//  Blockchain
//
//  Created by Alex McGregor on 8/24/18.
//  Copyright © 2018 Blockchain Luxembourg S.A. All rights reserved.
//

import Foundation

class ExchangeListPresenter {
    fileprivate let interactor: ExchangeListInput
    weak var interface: ExchangeListInterface?
    
    init(interactor: ExchangeListInput) {
        self.interactor = interactor
    }
}

extension ExchangeListPresenter: ExchangeListDelegate {
    func onLoaded() {
        interface?.enablePullToRefresh()
        interface?.refreshControlVisibility(.visible)
        interactor.fetchAllTrades()
    }
    
    func onDisappear() {
        interactor.cancel()
    }
    
    func onNextPageRequest(_ identifier: String) {
        guard interactor.canPage() else { return }
        interface?.paginationActivityIndicatorVisibility(.visible)
        interactor.nextPageBefore(identifier: identifier)
    }
    
    func onNewOrderTapped() {
        interface?.showNewExchange(animated: true)
    }
    
    func onPullToRefresh() {
        interface?.refreshControlVisibility(.visible)
        interactor.refresh()
    }

    func onTradeCellTapped(_ trade: ExchangeTradeModel) {
        interface?.showTradeDetails(trade: trade)
    }
}

extension ExchangeListPresenter: ExchangeListOutput {
    func willApplyUpdate() {
        // TODO:
    }
    
    func didApplyUpdate() {
        // TODO:
    }
    
    // swiftlint:disable line_length
    // swiftlint:disable force_try

    func loadedTrades(_ trades: [ExchangeTradeModel]) {
        interface?.refreshControlVisibility(.hidden)
        let payload = " { \"id\": \"039267ab-de16-4093-8cdf-a7ea1c732dbd\", \"state\": \"FINISHED\", \"createdAt\": \"2018-09-19T12:20:42.894Z\", \"updatedAt\": \"2018-09-19T12:24:18.943Z\", \"pair\": \"ETH-BTC\", \"refundAddress\": \"0xD1220A0cf47c7B9Be7A2E6BA89F429762e7b9aDb\", \"rate\": \"0.1\", \"depositAddress\": \"0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359\", \"deposit\": { \"symbol\": \"ETH\", \"value\": \"100.0\" }, \"withdrawalAddress\": \"3H4w1Sqk8UNNEfZoa9Z8FZJ6RYHrxLmzGU\", \"withdrawal\": { \"symbol\": \"BTC\", \"value\": \"10.0\" }, \"withdrawalFee\": { \"symbol\": \"BTC\", \"value\": \"0.0000001\" }, \"fiatValue\": { \"symbol\": \"GBP\", \"value\": \"10.0\" }, \"depositTxHash\": \"e6a5cfee8063330577babb6fb92eabccf5c3c1aeea120c550b6779a6c657dfce\", \"withdrawalTxHash\": \"0xf902adc8862c6c6ad2cd06f12d952e95c50ad783bae50ef952e1f54b7762a50e\" }".data(using: .utf8)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let final = try! decoder.decode(ExchangeTradeCellModel.self, from: payload!)
        let trade = ExchangeTradeModel.homebrew(final)
        interface?.display(results: [trade])
    }

    func appendTrades(_ trades: [ExchangeTradeModel]) {
        interface?.paginationActivityIndicatorVisibility(.hidden)
        interface?.append(results: trades)
    }
    
    func refreshedTrades(_ trades: [ExchangeTradeModel]) {
        interface?.refreshControlVisibility(.hidden)
        interface?.display(results: trades)
    }
    
    func tradeWithIdentifier(_ identifier: String) -> ExchangeTradeModel? {
        return interactor.tradeSelectedWith(identifier: identifier)
    }
    
    func tradeFetchFailed(error: Error?) {
        // TODO:
    }
}
