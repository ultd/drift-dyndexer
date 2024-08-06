CREATE DATABASE drift_events;
CREATE USER drift_events WITH ENCRYPTED PASSWORD 'drift_events';
GRANT ALL PRIVILEGES ON DATABASE drift_events TO drift_events;
\c drift_events postgres
GRANT ALL ON SCHEMA public TO drift_events;

\connect drift_events drift_events

CREATE TABLE IF NOT EXISTS "CurveRecord" (
	"adjustmentCost" text not null,
	"baseAssetAmountLong" text not null,
	"baseAssetAmountShort" text not null,
	"baseAssetAmountWithAmm" text not null,
	"baseAssetReserveAfter" text not null,
	"baseAssetReserveBefore" text not null,
	"fillRecord" text not null,
	"marketIndex" int not null,
	"numberOfUsers" bigint not null,
	"oraclePrice" bigint not null,
	"pegMultiplierAfter" text not null,
	"pegMultiplierBefore" text not null,
	"quoteAssetReserveAfter" text not null,
	"quoteAssetReserveBefore" text not null,
	"recordId" text not null,
	"sqrtKAfter" text not null,
	"sqrtKBefore" text not null,
	"totalFee" text not null,
	"totalFeeMinusDistributions" text not null,
	"ts" bigint not null
);

CREATE TABLE IF NOT EXISTS "DepositRecord" (
	"amount" text not null,
	"depositRecordId" text not null,
	"direction" jsonb not null,
	"explanation" jsonb not null,
	"marketCumulativeBorrowInterest" text not null,
	"marketCumulativeDepositInterest" text not null,
	"marketDepositBalance" text not null,
	"marketIndex" int not null,
	"marketWithdrawBalance" text not null,
	"oraclePrice" bigint not null,
	"totalDepositsAfter" text not null,
	"totalWithdrawsAfter" text not null,
	"transferUser" text,
	"ts" bigint not null,
	"user" text not null,
	"userAuthority" text not null
);

CREATE TABLE IF NOT EXISTS "FundingPaymentRecord" (
	"ammCumulativeFundingLong" text not null,
	"ammCumulativeFundingShort" text not null,
	"baseAssetAmount" bigint not null,
	"fundingPayment" bigint not null,
	"marketIndex" int not null,
	"ts" bigint not null,
	"user" text not null,
	"userAuthority" text not null,
	"userLastCumulativeFunding" bigint not null
);

CREATE TABLE IF NOT EXISTS "FundingRateRecord" (
	"baseAssetAmountWithAmm" text not null,
	"baseAssetAmountWithUnsettledLp" text not null,
	"cumulativeFundingRateLong" text not null,
	"cumulativeFundingRateShort" text not null,
	"fundingRate" bigint not null,
	"fundingRateLong" text not null,
	"fundingRateShort" text not null,
	"markPriceTwap" text not null,
	"marketIndex" int not null,
	"oraclePriceTwap" bigint not null,
	"periodRevenue" bigint not null,
	"recordId" text not null,
	"ts" bigint not null
);

CREATE TABLE IF NOT EXISTS "InsuranceFundRecord" (
	"amount" bigint not null,
	"insuranceVaultAmountBefore" text not null,
	"perpMarketIndex" int not null,
	"spotMarketIndex" int not null,
	"totalIfFactor" bigint not null,
	"totalIfSharesAfter" text not null,
	"totalIfSharesBefore" text not null,
	"ts" bigint not null,
	"userIfFactor" bigint not null,
	"vaultAmountBefore" text not null
);

CREATE TABLE IF NOT EXISTS "InsuranceFundStakeRecord" (
	"action" jsonb not null,
	"amount" text not null,
	"ifSharesAfter" text not null,
	"ifSharesBefore" text not null,
	"insuranceVaultAmountBefore" text not null,
	"marketIndex" int not null,
	"totalIfSharesAfter" text not null,
	"totalIfSharesBefore" text not null,
	"ts" bigint not null,
	"userAuthority" text not null,
	"userIfSharesAfter" text not null,
	"userIfSharesBefore" text not null
);

CREATE TABLE IF NOT EXISTS "LPRecord" (
	"action" jsonb not null,
	"deltaBaseAssetAmount" bigint not null,
	"deltaQuoteAssetAmount" bigint not null,
	"marketIndex" int not null,
	"nShares" text not null,
	"pnl" bigint not null,
	"ts" bigint not null,
	"user" text not null
);

CREATE TABLE IF NOT EXISTS "LiquidationRecord" (
	"bankrupt" boolean not null,
	"canceledOrderIds" jsonb not null,
	"liquidateBorrowForPerpPnl" jsonb not null,
	"liquidatePerp" jsonb not null,
	"liquidatePerpPnlForDeposit" jsonb not null,
	"liquidateSpot" jsonb not null,
	"liquidationId" int not null,
	"liquidationType" jsonb not null,
	"liquidator" text not null,
	"marginFreed" text not null,
	"marginRequirement" text not null,
	"perpBankruptcy" jsonb not null,
	"spotBankruptcy" jsonb not null,
	"totalCollateral" text not null,
	"ts" bigint not null,
	"user" text not null
);

CREATE TABLE IF NOT EXISTS "NewUserRecord" (
	"name" jsonb not null,
	"referrer" text not null,
	"subAccountId" int not null,
	"ts" bigint not null,
	"user" text not null,
	"userAuthority" text not null
);

CREATE TABLE IF NOT EXISTS "OrderActionRecord" (
	"action" jsonb not null,
	"actionExplanation" jsonb not null,
	"baseAssetAmountFilled" text,
	"fillRecordId" text,
	"filler" text,
	"fillerReward" text,
	"maker" text,
	"makerFee" bigint,
	"makerOrderBaseAssetAmount" text,
	"makerOrderCumulativeBaseAssetAmountFilled" text,
	"makerOrderCumulativeQuoteAssetAmountFilled" text,
	"makerOrderDirection" jsonb,
	"makerOrderId" bigint,
	"marketIndex" int not null,
	"marketType" jsonb not null,
	"oraclePrice" bigint not null,
	"quoteAssetAmountFilled" text,
	"quoteAssetAmountSurplus" bigint,
	"referrerReward" bigint,
	"spotFulfillmentMethodFee" text,
	"taker" text,
	"takerFee" text,
	"takerOrderBaseAssetAmount" text,
	"takerOrderCumulativeBaseAssetAmountFilled" text,
	"takerOrderCumulativeQuoteAssetAmountFilled" text,
	"takerOrderDirection" jsonb,
	"takerOrderId" bigint,
	"ts" bigint not null
);

CREATE TABLE IF NOT EXISTS "OrderRecord" (
	"order" jsonb not null,
	"ts" bigint not null,
	"user" text not null
);

CREATE TABLE IF NOT EXISTS "SettlePnlRecord" (
	"baseAssetAmount" bigint not null,
	"explanation" jsonb not null,
	"marketIndex" int not null,
	"pnl" text not null,
	"quoteAssetAmountAfter" bigint not null,
	"quoteEntryAmount" bigint not null,
	"settlePrice" bigint not null,
	"ts" bigint not null,
	"user" text not null
);

CREATE TABLE IF NOT EXISTS "SpotInterestRecord" (
	"borrowBalance" text not null,
	"cumulativeBorrowInterest" text not null,
	"cumulativeDepositInterest" text not null,
	"depositBalance" text not null,
	"marketIndex" int not null,
	"maxBorrowRate" bigint not null,
	"optimalBorrowRate" bigint not null,
	"optimalUtilization" bigint not null,
	"ts" bigint not null
);

CREATE TABLE IF NOT EXISTS "SwapRecord" (
	"amountIn" text not null,
	"amountOut" text not null,
	"fee" text not null,
	"inMarketIndex" int not null,
	"inOraclePrice" bigint not null,
	"outMarketIndex" int not null,
	"outOraclePrice" bigint not null,
	"ts" bigint not null,
	"user" text not null
);

