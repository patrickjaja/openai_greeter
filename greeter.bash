#!/bin/bash

commands=("curl" "jq" "tr" "espeak")

for cmd in "${commands[@]}"; do
    if not which "$cmd" >/dev/null; then
        echo "$cmd is not installed"
        exit 0
    fi
done

source .env

vars_to_check=("GREETER_NAME" "OPENAPI_API_KEY")

for var in "${vars_to_check[@]}"; do
  if [ -v "${var}" ]; then
    echo "${var} is set"
  else
    echo "${var} is not set"
    exit 0
  fi
done

curl https://api.openai.com/v1/completions \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${YOUR_API_KEY_HERE}" \
  -d "{
       \"model\": \"text-davinci-003\",
       \"prompt\": \"Hello my Name is ${GREETER_NAME}. Please greet me in a short way. Surprise me in a funny way.\",
       \"max_tokens\": 100,
       \"temperature\": 0.8
     }" \
 | jq -r '.choices[0].text' | tr -d '\n' | espeak
