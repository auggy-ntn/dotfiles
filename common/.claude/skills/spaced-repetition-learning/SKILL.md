---
name: spaced-repetition-learning
description: Spaced repetition learning tool. Use when the user wants to study or review a concept using active recall.
---

# Spaced Repetition Learning Skill

## Steps
1. Ask the user to explain their understanding of the concept in their own words
2. Identify gaps or misconceptions in their explanation
3. Ask 2-3 targeted follow-up questions to probe weak areas
4. After the session, summarize:
   - What they understood well ✅
   - Gaps identified ⚠️
   - Suggested review date
5. Append the result to `~/.claude/learning_log.json` with today's date
```
