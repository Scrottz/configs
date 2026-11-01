# Custom shell functions.
# q() is a temporary minimal LLM chat wrapper. It will move into llm/ when the
# session handling is rebuilt.

# Chat with the model in the fixed conversation "zsh".
q() {
    llm -m openrouter/anthropic/claude-haiku-5.5 --cid zsh "$*"
}
