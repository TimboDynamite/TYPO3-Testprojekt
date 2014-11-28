SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE matches_answers;
TRUNCATE matches_questions;
TRUNCATE matches_sessions;
TRUNCATE matches;
UPDATE users SET matches_played = 0, matches_won = 0, matches_lost = 0, points = 0, bufferedpoints = 0;
SET FOREIGN_KEY_CHECKS = 1;
