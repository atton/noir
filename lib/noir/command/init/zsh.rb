class Noir::Command::Init::Zsh < Noir::Base::TerminalCommand
  @description = "init script for zsh"

  # enable completion for zsh
  # wrote this code in .zshrc
  # if which noir  >& /dev/null; then eval "$(noir init zsh)"; fi

  InitScript = %q(

if [[ ! -o interactive ]]; then
  return
fi

compctl -K _noir noir

_noir() {
  local words completions
  read -cA words

  completions="$(noir completion ${words[2,-2]})"

  reply=("${(ps:\n:)completions}")
}

  )
  class << self

    def execute *args
      puts InitScript
    end

  end
end
