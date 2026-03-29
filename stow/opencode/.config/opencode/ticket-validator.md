# Goal
I want you to create a new slash command for grading ticket qualities.

## Process
The slash command should follow this process:

### Input:
1. either a path to a markdown file containing a PRD
2. or at least 1 Jira ticket key (KEY-123).

### Research phase:
1.2. given a path to markdown file as input: read the file contents
1.2. if given Jira ticket key(s), use the atlassian-mcp to fetch the given ticket(s) and all subtasks. 
2. Then use the specs-mcp to fetch relevant specs for the context. Use search_specs at least once (preferably multiple times with relevant queries). Then use read_spec for each found spec in the search. Analyze all specs for more relevant search queries, and call search_specs again for each new relevant search query.

The goal  of this phase is to gather as much relevant content as possible for the next phase.

### Grading phase:
Then i want you to perform a grading of the PRD / ticket contents against the gained knowledge from the specs.
I want a score from 1-10 (10 best, less than 8 requires refinement from product).
Come up with a sophisticated scoring system.

### Ouput

Output a grading report, listing the scores in each of the categories, a list of failures, and a final list of suggestions.

