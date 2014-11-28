SELECT
            matches.`id` AS match_id,
            IF(matches.`user` = "ki-12962", matches.`user`, matches.`opponent`) AS match_user,
            IF(matches.`user` != "ki-12962", matches.`user`, matches.`opponent`) AS match_opponent,
            IF(matches.`user` = "ki-12962", "challenger", "challengee") AS role,
            users_a.`nickname` AS user_nickname,
            users.`nickname` AS opponent_nickname,
            matches_sessions_a.`completed` AS user_completed,
            matches_sessions_a.`time` AS user_time,
            matches_sessions_b.`completed` AS opponent_completed,
            matches_sessions_b.`time` AS opponent_time,
            matches_sessions_a.`created` AS user_session_created,
            matches_sessions_b.`created` AS opponent_session_created,
            COUNT(matches_answers_a.`answer`) AS result,
            COUNT(matches_answers_b.`answer`) AS opponent_result,
            100 * COUNT(matches_answers_a.`answer`) AS points,
            UNIX_TIMESTAMP(GREATEST(IFNULL(matches_sessions_a.`created`, 0),IFNULL(matches_sessions_b.`created`, 0))) AS timestamp

            FROM matches

            LEFT JOIN matches_sessions AS matches_sessions_a
            ON matches_sessions_a.`match` = matches.`id`
            AND matches_sessions_a.`user` = IF(matches.`user` = "ki-12962", matches.`user`, matches.`opponent`)

            LEFT JOIN matches_sessions AS matches_sessions_b
            ON matches_sessions_b.`match` = matches.`id`
            AND matches_sessions_b.`user` = IF(matches.`user` != "ki-12962", matches.`user`, matches.`opponent`)

            LEFT JOIN users AS users_a
            ON users_a.`id` = IF(matches.`user` = "ki-12962", matches.`user`, matches.`opponent`)

            LEFT JOIN users
            ON users.`id` = IF(matches.`user` != "ki-12962", matches.`user`, matches.`opponent`)

            LEFT JOIN matches_questions
            ON matches_questions.`match` = matches.`id`

            LEFT JOIN answers
            ON answers.`question` = matches_questions.`question`
            AND answers.`correct` = "Y"

            LEFT JOIN matches_answers AS matches_answers_a
            ON matches_answers_a.`session` = matches_sessions_a.`id`
            AND matches_answers_a.`answer` = answers.`id`

            LEFT JOIN matches_answers AS matches_answers_b
            ON matches_answers_b.`session` = matches_sessions_b.`id`
            AND matches_answers_b.`answer` = answers.`id`

            WHERE (matches.`user` = "ki-12962" OR matches.`opponent` = "ki-12962")
            AND (matches_sessions_a.`completed` = "Y" OR matches_sessions_b.`completed` = "Y")
            AND NOT (
                (
                    matches_sessions_a.`created` IS NULL OR
                    matches_sessions_a.`created` < FROM_UNIXTIME(1)
                ) AND (
                    matches_sessions_b.`created` IS NULL OR
                    matches_sessions_b.`created` < FROM_UNIXTIME(1)
                ))
         	GROUP by matches.`id`
         	ORDER BY timestamp DESC
