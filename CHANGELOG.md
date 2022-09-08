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
  