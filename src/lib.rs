use std::sync::OnceLock;

use syndica_dyndexer_runtime::{anchor::AnchorIdl, processor, record_output, Event, Output};

const DRIFT_PROGRAM_PUBKEY: &str = "dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH";
const DRIFT_IDL: &[u8] = include_bytes!("drift.json");

static IDL: OnceLock<AnchorIdl> = OnceLock::new();

// This processor tracks any new user in Drift

#[processor]
fn process_events(event: Event) {
    let idl = IDL.get_or_init(|| AnchorIdl::deserialize(DRIFT_PROGRAM_PUBKEY, DRIFT_IDL));
    if let Event::Transaction(tx) = event {
        let events = idl.parse_events(&tx);

        for event in events {
            if event.name == "SwapRecord" {
                record_output(&Output::Object {
                    uid: tx.signature.clone(),
                    key: event.name,
                    value: event.data,
                });
            }
        }
    }
}
