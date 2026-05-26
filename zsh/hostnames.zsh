typeset -A hostnames=(
  K4L7X4FWFW "work"
  lukelaptop "personal"
  grombert-crombert "personal"
)

function idhost() {
  echo $hostnames[$HOST]
}
