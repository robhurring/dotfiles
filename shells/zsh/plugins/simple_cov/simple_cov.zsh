export SIMPLE_COV_DIRECTORY=coverage
export SIMPLE_COV_DATA_FILE=$SIMPLE_COV_DIRECTORY/.last_run.json

ocov() {
  local COVERAGE_FILE=$SIMPLE_COV_DIRECTORY/index.html
  [[ -f $COVERAGE_FILE ]] && open $COVERAGE_FILE || echo "No coverage file found!"
}

cov() {
  local PERCENT;

  if [[ -f $SIMPLE_COV_DATA_FILE ]]; then
    PERCENT=$(cat $SIMPLE_COV_DATA_FILE|grep covered_percent|cut -d ":" -f 2)
    print -n "Coverage:$PERCENT% "
  else
    echo "No coverage last run file found!"
  fi
}

SIMPLE_COV_THRESHOLD=95
SIMPLE_COV_ICON_GOOD="%F{green}✓%f"
SIMPLE_COV_ICON_BAD="%F{red}✗%f"
simple_cov_prompt_info() {
  local ICON

  if [[ -f $SIMPLE_COV_DATA_FILE ]]; then
    PERCENT=$(cat $SIMPLE_COV_DATA_FILE|grep covered_percent|cut -d ":" -f 2)
    if [[ $PERCENT -gt $SIMPLE_COV_THRESHOLD ]]; then
      ICON=$SIMPLE_COV_ICON_GOOD
    else
      ICON=$SIMPLE_COV_ICON_BAD
    fi
    print -n $ICON
  fi
}