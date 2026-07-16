# --- Environment ---
export DEFAULT_USER="shafer.361"
export GITLAB_HOST="https://code.osu.edu/"
export DOCKER_HOST="unix:/$HOME/.docker/run/docker.sock"

# --- PATH ---
export PATH="/opt/homebrew/opt/openjdk11/bin:$PATH"

# --- Node (nvm) ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# --- SAM (build/deploy) ---
alias sb="sam build --config-env ls"
alias sd="sam deploy --config-env ls --profile dev-crmi"
alias sdg="sam deploy --guided --profile dev-crmi"
alias sbd="(sb && sd && say \"SAM deployment successful\") || say \"SAM deployment failed\""

alias sb-dev="sam build --config-env dev"
alias sd-dev="sam deploy --config-env dev --profile qa-crmi"
alias sbd-dev="(sb-dev && sd-dev && say \"Dev deployment successful\") || say \"Dev deployment failed\""

alias sb-qa="sam build --config-env qa"
alias sd-qa="sam deploy --config-env qa --profile qa-crmi"
alias sbd-qa="(sb-qa && sd-qa && say \"QA deployment successful\") || say \"QA deployment failed\""

# --- AWS ---
alias awslogin="aws sts get-caller-identity --profile dev-crmi"
alias awslogin-qa="aws sts get-caller-identity --profile qa-crmi"
alias awslogin-prod="aws sts get-caller-identity --profile prod-crmi"

# --- CRMI project helpers ---
alias npm-i-handlers="cd ./src/lambda/handlers/ && (find . -maxdepth 2 -name package.json -execdir npm i \;) && cd -"
alias npm-i-lib="cd ./src/lambda/lib/ && npm i && cd -"
alias npm-i-all="install-handlers && install-lib"

alias npm-u-handlers="cd ./src/lambda/handlers/ && (find . -maxdepth 2 -name package.json -execdir npm up \;) && cd -"
alias npm-u-lib="cd ./src/lambda/lib/ && npm up && cd -"
alias npm-u-all="update-handlers && update-lib"

function common-explain() {
  if [ -z "$1" ]; then
    echo "Usage: common-explain <package-name>"
    return 1
  fi
  cd $HOME/repos/crmi/common/src/lambda/layers/crmi-common-lambda-layer/nodejs
  npm explain $1
  cd -
}

# --- Kiro ---
alias klogin="kiro-cli login --license pro --identity-provider $KIRO_START_URL --region us-east-2 --use-device-flow"
alias kcli="kiro-cli"

# --- Notes ---
alias today="date \"+%m-%d.md\""

function notes() {
  nvim "$HOME/repos/notes/$(today)"
}
