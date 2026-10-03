SKILLS_DIR := $(HOME)/.claude/skills
SKILLS     := $(patsubst %/SKILL.md,%,$(wildcard */SKILL.md))
NAME       := $(word 2,$(MAKECMDGOALS))

.DEFAULT_GOAL := help
.PHONY: help install $(SKILLS)

help: ## Show this help
	@echo "Usage: make <target>"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-10s %s\n", $$1, $$2}'
	@echo ""
	@echo "Skills: $(SKILLS)"

install: ## Link skill into ~/.claude/skills (make install <name>)
	@test -n "$(NAME)" || { echo "usage: make install <name>"; exit 1; }
	@test -f "$(NAME)/SKILL.md" || { echo "unknown skill: $(NAME)"; exit 1; }
	@mkdir -p "$(SKILLS_DIR)"
	@ln -sfn "$(CURDIR)/$(NAME)" "$(SKILLS_DIR)/$(NAME)"
	@echo "linked $(SKILLS_DIR)/$(NAME) -> $(CURDIR)/$(NAME)"

# swallow the skill name passed as a goal (make install <name>)
$(SKILLS):
	@:

%:
	@:
