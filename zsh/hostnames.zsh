typeset -A hostnames=(
  K4L7X4FWFW "work"
  lukelaptop "personal"
  gombertcrombert "personal"
)

function idhost() {
  echo $hostnames[$HOST]
}
