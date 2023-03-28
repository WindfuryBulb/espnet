#!/usr/bin/env bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set="train_nodev"
valid_set="train_dev"
test_sets="test train_dev"

asr_config=conf/train_asr_transformer.yaml
inference_config=conf/decode_asr.yaml

./asr.sh \
    --stage 1 \
    --stop_stage 13 \
    --lang en \
    --ngpu 1 \
    --nj 2 \
    --gpu_inference true \
    --inference_nj 2 \
    --token_type "word" \
    --speed_perturb_factors "0.9 1.0 1.1" \
    --audio_format "wav" \
    --feats_type raw \
    --use_lm false \
    --asr_config "${asr_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --lm_train_text "data/${train_set}/text" \
    --bpe_train_text "data/${train_set}/text" "$@" \
    --max_wav_duration 300 \
    --min_wav_duration 60