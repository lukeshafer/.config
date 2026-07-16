export DEFAULT_USER="shafer.361"

# User configuration

export PC_CONTEXT="work"

export GITLAB_HOST="https://code.osu.edu/"
export GLAMOUR_STYLE="dark"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export NVM_DIR="$HOME/.nvm"
# # Lazy-load nvm
# _load_nvm() {
#   unset -f nvm node npm npx _load_nvm
#   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#   [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# }
# nvm() { _load_nvm; nvm "$@"; }
# node() { _load_nvm; node "$@"; }
# npm() { _load_nvm; npm "$@"; }
# npx() { _load_nvm; npx "$@"; }


export PATH="/opt/homebrew/opt/openjdk11/bin:$PATH"

# custom scripts
export PATH="$HOME/.local/bin:$PATH"
export DOCKER_HOST="unix:/$HOME/.docker/run/docker.sock"

# Custom sam aliases
alias sb="sam build --config-env ls"
alias sd="sam deploy --config-env ls --profile dev-crmi"
alias sdg="sam deploy --guided --profile dev-crmi"
alias sbd="(sb && sd && say \"SAM deployment successful\") || say \"SAM deployment failed\""

alias sb-qa="sam build --config-env qa"
alias sd-qa="sam deploy --config-env qa --profile qa-crmi"
alias sbd-qa="(sb-qa && sd-qa && say \"QA deployment successful\") || say \"QA deployment failed\""

alias mrc='glab mr create -b dev -f -y'
alias mrcqa='glab mr create -b qa -y'
alias mrdraft='glab mr create -b dev -f -y --draft'
alias mrm='glab mr merge'

alias awslogin="aws sts get-caller-identity --profile dev-crmi"
# alias awslogout="rm ~/.aws/saml-credentials"
alias awsreset="awslogout && awslogin"

alias awslogin-qa="aws sts get-caller-identity --profile qa-crmi"
alias awslogin-prod="aws sts get-caller-identity --profile prod-crmi"

alias install-handlers="cd ./src/lambda/handlers/ && (find . -maxdepth 2 -name package.json -execdir npm i \;) && cd -"
alias install-lib="cd ./src/lambda/lib/ && npm i && cd -"
alias install-all="install-handlers && install-lib"

alias update-handlers="cd ./src/lambda/handlers/ && (find . -maxdepth 2 -name package.json -execdir npm up \;) && cd -"
alias update-lib="cd ./src/lambda/lib/ && npm up && cd -"
alias update-all="update-handlers && update-lib"

alias git-node20-branch="git checkout -b @features/node20-upgrade && git push --set-upstream origin @features/node20-upgrade"

function common-explain() {
	if [ -z "$1" ]; then
		echo "Usage: common-explain <package-name>"
		return 1
	fi

  cd ~/repos/crmi-repos/crmi-common/src/lambda/layers/crmi-common-lambda-layer/nodejs
  npm explain $1
  cd -
}

#alias klogin="echo $KIRO_START_URL | pbcopy && kiro-cli login"
alias klogin="kiro-cli login --license pro --identity-provider $KIRO_START_URL --region us-east-2 --use-device-flow"
alias kcli="kiro-cli"
# zprof

alias today="date \"+%m-%d.md\" "

function notes() {
  nvim "~/repos/notes/$(today)"
}
