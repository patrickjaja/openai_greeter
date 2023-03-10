#!/bin/bash

commands=("curl" "jq" "tr" "espeak")

for cmd in "${commands[@]}"; do
    if which "$cmd" >/dev/null; then
        echo "$cmd is installed"
    else
        echo "$cmd is not installed"
    fi
done

curl https://api.openai.com/v1/completions \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${OPENAPI_API_KEY}" \
  -d '{
  "model": "text-davinci-003",
  "prompt": "Hello my Name is Patrick. Please greet me in a short way. Suprise me in a funny way.",
  "max_tokens": 100,
  "temperature": 0.8
}' \
 | jq -r '.choices[0].text' | tr -d '\n' | espeak
