CREATE DATABASE drift_events;
CREATE USER drift_events WITH ENCRYPTED PASSWORD 'drift_events';
GRANT ALL PRIVILEGES ON DATABASE drift_events TO drift_events;
\c drift_events postgres
GRANT ALL ON SCHEMA public TO drift_events;

\connect drift_events
CREATE TABLE IF NOT EXISTS "SwapRecord" (
    "ts" bigint NOT NULL,
    "user" text NOT NULL,
    "amountOut" bigint NOT NULL,
    "amountIn" bigint NOT NULL,
    "outMarketIndex" int NOT NULL,
    "inMarketIndex" int NOT NULL
);