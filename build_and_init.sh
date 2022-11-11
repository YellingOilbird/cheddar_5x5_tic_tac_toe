#!/usr/bin/env bash
set -e

# REQUIRED! - ./neardev/tic_tac_toe/dev-account empty file for deployment

rm neardev/tic_tac_toe/*

################################################################################

RUSTFLAGS='-C link-arg=-s' cargo build --target wasm32-unknown-unknown --release
cp target/wasm32-unknown-unknown/release/*.wasm ./res/
near dev-deploy --wasmFile ./res/cheddar_tic_tac_toe.wasm  \
		--initFunction "new" \
		--projectKeyDirectory ./neardev/tic_tac_toe/ \
		--initArgs '{
            "config": {
                "service_fee_percentage": 200,
                "referrer_ratio": 5000,
                "max_game_duration_sec": 3600,
                "max_stored_games": 50
            }
		}'

TICTACTOE=$(cat neardev/tic_tac_toe/dev-account)