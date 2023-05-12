## 1.1.10
* Add address parser for `bitcoin:<address>`, `bsc:<address>` and `ethereum:<address>`
## 1.1.9
* Fix - Allow utxo transact full balance
* Add `utxoCoinWithExceptionHandling`
* `utxoCoin` does not throw exceptions now. They must be handled in main app.
* Fix - transaction fee is now calculated inside sio_core_light not inherited from trust_wallet_core_lib
## 1.1.8
* Fix Eth sign normal messages (not converted already to hex by the Dapp)
## 1.1.7
* Add supported network check
## 1.1.6
* Remove bnb testnet from network groups
* Implement public address validator for supported coins
## 1.1.5
* Add bnb testnet in network groups
* Generate 12 instead of 24 words mnemonic now
## 1.1.4
* Improve arguments types
## 1.1.3
* Implement Ethereum message signing
## 1.1.2
* Fix: `Transaction` arguments non null-able
## 1.1.1
* fix: rename `Cluster.utxo`
## 1.1.0
* Implement `networkId` method for `EthNetworks`
* Implement `assetId` method for `Networks`
* Refactor: move `NetworkGroups` under `Cluster`
* Refactor `chainId` method
* Implement `EthChainId` and `SioAssetId`
* Fix: improve utxo exceptions
## 1.0.3
* Expose `data` argument for ETH transactions
* Now `amount` argument for ETH transactions is in `wei` instead of `gwei`
* Fix bugs in methods documentation
* Small bug fixes
## 1.0.2
* Add network groups for buildTx organization
## 1.0.1
* Expose Transaction class
## 1.0.0
* Implement SOL native and token (SPL) transactions
* Implement UTXO transactions (BTC, BCH, DASH, DGB, DOGE, FLUX, LTC, ZEC)
* Implement legacy transactions for Ethereum native and token transactions (BSC, ETC)
* Implement EIP1559 transactions for Ethereum native and token transactions (AVAX, ETH, MATIC)
* Implement Cosmos native transactions (ATOM, OSMO)
  