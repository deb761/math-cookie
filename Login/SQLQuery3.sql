SELECT StudentID, MAX(Results.Level) AS [Current Level],
	(SELECT DISTINCT
	 CONCAT(FORMAT(Probs.Operator1, 'D'), ' + ', FORMAT(Probs.Operator2, 'D'), ' = ', FORMAT(R.Answer, 'D'), ', ')
		FROM Results AS R
		JOIN AddSubProblems AS Probs ON Probs.AddSubProblemID = R.ProblemID
		WHERE R.StudentID = Results.StudentID AND Probs.Result != R.Answer AND R.ProblemID = Probs.AddSubProblemID
		FOR XML PATH('')) AS Answers
	FROM Results
	JOIN AddSubProblems AS Probs ON Probs.AddSubProblemID = Results.ProblemID
	GROUP BY StudentID, Results.Level