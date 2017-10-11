# Introduction

- Student nam:  Shubh Maheshwari
- Student Roll Number: 20161170
- Code Review of: 20161170/new
- Lines of code reviewed: 375
- Number of classes: 6
- Number of methods: 30
- Bugs identified: 6 (pseudo) & 0 (fatal) 
- Code smells identified: 100

## Conventions and Smells

This file contains the details of the errors and styling problems after refactoring the code. 
The final score of the code after refactoring is 5.42/10.  The errors have been highlighted  below.


# Errors
##  Module Assignment3.new.asciiDrawings
```
C: 62, 0: Line too long (118/100) (line-too-long)
C: 73, 0: Line too long (116/100) (line-too-long)
C: 74, 0: Line too long (116/100) (line-too-long)
C: 75, 0: Line too long (116/100) (line-too-long)
C: 76, 0: Line too long (113/100) (line-too-long)
C: 77, 0: Line too long (122/100) (line-too-long)
C: 79, 0: Line too long (113/100) (line-too-long)
C: 80, 0: Line too long (119/100) (line-too-long)
C: 81, 0: Line too long (122/100) (line-too-long)
C: 82, 0: Line too long (116/100) (line-too-long)
C: 83, 0: Line too long (102/100) (line-too-long)
C:  1, 0: Invalid module name "asciiDrawings" (invalid-name)
C:  1, 0: Missing module docstring (missing-docstring)
C:  5, 0: Missing function docstring (missing-docstring)
C: 72, 0: Missing function docstring (missing-docstring)
C: 86, 0: Missing function docstring (missing-docstring)
```

## Module Assignment3.new.Block
```
C:  1, 0: Missing module docstring (missing-docstring)
C: 12, 8: Invalid attribute name "enemy2Upper" (invalid-name)
C: 13, 8: Invalid attribute name "enemy2Lower" (invalid-name)
C:  8, 8: Invalid attribute name "bombermanUpper" (invalid-name)
C:  9, 8: Invalid attribute name "bombermanLower" (invalid-name)
C: 14, 8: Invalid attribute name "bombBlast" (invalid-name)
C: 10, 8: Invalid attribute name "enemy1Upper" (invalid-name)
C: 11, 8: Invalid attribute name "enemy1Lower" (invalid-name)
C:  2, 0: Missing class docstring (missing-docstring)
R:  2, 0: Too many instance attributes (10/7) (too-many-instance-attributes)
C: 16, 4: Invalid method name "getBlock" (invalid-name)
C: 16, 4: Invalid argument name "a" (invalid-name)
C: 16, 4: Invalid argument name "b" (invalid-name)
C: 16, 4: Missing method docstring (missing-docstring)
R: 16, 4: Too many return statements (12/6) (too-many-return-statements)
C: 54, 4: Invalid method name "getColor" (invalid-name)
C: 54, 4: Invalid argument name "a" (invalid-name)
C: 54, 4: Missing method docstring (missing-docstring)
R: 54, 4: Method could be a function (no-self-use)
R: 54, 4: Too many return statements (9/6) (too-many-return-statements)
```

## Module Assignment3.new.Board
```
C: 91, 0: Line too long (105/100) (line-too-long)
C:112, 0: Wrong continued indentation (remove 1 space).
                                     ][game.bomb.x + dirx[i]] = 'x'
                                    |^ (bad-continuation)
C:114, 0: Line too long (101/100) (line-too-long)
C:118, 0: Line too long (103/100) (line-too-long)
C:122, 0: Line too long (113/100) (line-too-long)
C:124, 0: Line too long (105/100) (line-too-long)
C:127, 0: Line too long (111/100) (line-too-long)
C:132, 0: Line too long (107/100) (line-too-long)
C:135, 0: Line too long (111/100) (line-too-long)
C:140, 0: Line too long (107/100) (line-too-long)
C:145, 0: Wrong continued indentation (remove 1 space).
                                         ][game.bomb.x + 2 * dirx[i]] = 'x'
                                        |^ (bad-continuation)
C:155, 0: Wrong continued indentation (remove 1 space).
                                     ][game.bomb.x + dirx[i]] = ' '
                                    |^ (bad-continuation)
C:157, 0: Line too long (101/100) (line-too-long)
C:159, 0: Wrong continued indentation (remove 1 space).
                                         ][game.bomb.x + 2 * dirx[i]] = ' '
                                        |^ (bad-continuation)
C:226, 0: Line too long (112/100) (line-too-long)
C:240, 0: Line too long (112/100) (line-too-long)
C:  1, 0: Missing module docstring (missing-docstring)
E:  6, 0: Unable to import 'Block' (import-error)
E:  7, 0: Unable to import 'Person' (import-error)
C: 38, 8: Invalid attribute name "x" (invalid-name)
C: 39, 8: Invalid attribute name "y" (invalid-name)
C: 12, 0: Missing class docstring (missing-docstring)
C: 47, 4: Invalid method name "moveBomber" (invalid-name)
C: 47, 4: Missing method docstring (missing-docstring)
C: 48, 8: Invalid variable name "x" (invalid-name)
C: 49, 8: Invalid variable name "y" (invalid-name)
C: 64, 4: Invalid method name "updateBomb" (invalid-name)
C: 64, 4: Missing method docstring (missing-docstring)
W:163, 8: No exception type(s) specified (bare-except)
W: 66,12: Statement seems to have no effect (pointless-statement)
C: 82,16: Consider using enumerate instead of iterating with range and len (consider-using-enumerate)
R: 65, 8: Too many nested blocks (7/5) (too-many-nested-blocks)
R: 65, 8: Too many nested blocks (7/5) (too-many-nested-blocks)
R: 65, 8: Too many nested blocks (8/5) (too-many-nested-blocks)
R: 65, 8: Too many nested blocks (8/5) (too-many-nested-blocks)
C:151,16: Consider using enumerate instead of iterating with range and len (consider-using-enumerate)
R: 65, 8: Too many nested blocks (6/5) (too-many-nested-blocks)
R: 64, 4: Too many branches (31/12) (too-many-branches)
R: 64, 4: Too many statements (58/50) (too-many-statements)
C:166, 4: Invalid method name "updateEnemy" (invalid-name)
C:166, 4: Missing method docstring (missing-docstring)
C:173,16: Invalid variable name "x" (invalid-name)
C:174,16: Invalid variable name "y" (invalid-name)
R:166, 4: Too many branches (30/12) (too-many-branches)
R:166, 4: Too many statements (68/50) (too-many-statements)
C:251, 4: Missing method docstring (missing-docstring)
W:  1, 0: Unused import random (unused-import)
W:  2, 0: Unused import sys (unused-import)
W:  3, 0: Unused import os (unused-import)
W:  4, 0: Unused import time (unused-import)
W:  5, 0: Unused import copy (unused-import)
W:  7, 0: Unused Enemy1 imported from Person (unused-import)
W:  7, 0: Unused Enemy2 imported from Person (unused-import)
C:  8, 0: standard import "from random import randint" comes before "from Block import Block" (wrong-import-order)
C:  8, 0: Imports from package random are not grouped (ungrouped-imports)
```

## Module Assignment3.new.Bomb
```
W:  4, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  4, 0: Exactly one space required after comma
	def __init__(self,x,y,time):
                  ^ (bad-whitespace)
C:  4, 0: Exactly one space required after comma
	def __init__(self,x,y,time):
                    ^ (bad-whitespace)
C:  4, 0: Exactly one space required after comma
	def __init__(self,x,y,time):
                      ^ (bad-whitespace)
W:  5, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  6, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  7, 0: Found indentation with tabs instead of spaces (mixed-indentation)
W:  9, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C: 10, 0: Final newline missing (missing-final-newline)
W: 10, 0: Found indentation with tabs instead of spaces (mixed-indentation)
C:  1, 0: Missing module docstring (missing-docstring)
E:  1, 0: Unable to import 'Block' (import-error)
C:  5, 2: Invalid attribute name "x" (invalid-name)
C:  6, 2: Invalid attribute name "y" (invalid-name)
C:  3, 0: Missing class docstring (missing-docstring)
C:  9, 1: Missing method docstring (missing-docstring)
R:  3, 0: Too few public methods (1/2) (too-few-public-methods)
W:  1, 0: Unused Block imported from Block (unused-import)
```

## Module Assignment3.new.game
```
C:148, 0: Unnecessary parens after 'while' keyword (superfluous-parens)
C:153, 0: Unnecessary parens after 'if' keyword (superfluous-parens)
C:  1, 0: Missing module docstring (missing-docstring)
E:  1, 0: Unable to import 'Board' (import-error)
E:  2, 0: Unable to import 'Bomb' (import-error)
E:  3, 0: Unable to import 'asciiDrawings' (import-error)
C: 21, 8: Invalid constant name "getch" (invalid-name)
C: 23, 4: Missing function docstring (missing-docstring)
C: 24, 8: Invalid variable name "fd" (invalid-name)
C: 28,12: Invalid variable name "ch" (invalid-name)
C: 34, 0: Invalid function name "alarmHandler" (invalid-name)
C: 34, 0: Missing function docstring (missing-docstring)
W: 34,17: Unused argument 'signum' (unused-argument)
W: 34,25: Unused argument 'frame' (unused-argument)
C: 38, 0: Missing class docstring (missing-docstring)
C: 45, 8: Invalid attribute name "x" (invalid-name)
C: 50, 8: Invalid attribute name "enemiesKilled" (invalid-name)
C: 46, 8: Invalid attribute name "y" (invalid-name)
C: 52, 8: Invalid attribute name "GAMEOVER" (invalid-name)
C: 42, 0: Missing class docstring (missing-docstring)
R: 42, 0: Too many instance attributes (8/7) (too-many-instance-attributes)
C: 54, 4: Missing method docstring (missing-docstring)
C: 70,12: Invalid variable name "x" (invalid-name)
C: 71,12: Invalid variable name "y" (invalid-name)
C: 85,19: Comparison to None should be 'expr is None' (singleton-comparison)
C: 97, 4: Missing method docstring (missing-docstring)
W: 99, 8: Redefining name 'points' from outer scope (line 142) (redefined-outer-name)
C:104, 4: Invalid method name "gameOver" (invalid-name)
C:104, 4: Missing method docstring (missing-docstring)
W:112, 8: No exception type(s) specified (bare-except)
C:115, 4: Invalid method name "gameWon" (invalid-name)
C:115, 4: Missing method docstring (missing-docstring)
R:115, 4: Method could be a function (no-self-use)
C:121, 4: Missing method docstring (missing-docstring)
C:126, 8: Invalid variable name "enemyCount" (invalid-name)
C:129,16: Invalid variable name "enemyCount" (invalid-name)
C:142, 4: Invalid constant name "points" (invalid-name)
C:143, 4: Invalid constant name "lives" (invalid-name)
C:144, 4: Invalid constant name "levels" (invalid-name)
C:147, 8: Invalid constant name "game" (invalid-name)
C:154,16: Invalid constant name "levels" (invalid-name)
C:158,40: Comparison to True should be just 'expr' or 'expr is True' (singleton-comparison)
W:162,12: No exception type(s) specified (bare-except)
C:161,16: Invalid constant name "points" (invalid-name)
C:164,11: Comparison to True should be just 'expr' or 'expr is True' (singleton-comparison)
C:165,12: Invalid constant name "lives" (invalid-name)
W:  5, 0: Unused import random (unused-import)
W:  9, 0: Unused import copy (unused-import)
C:  5, 0: standard import "import random" comes before "from Board import Board" (wrong-import-order)
C:  6, 0: standard import "import sys" comes before "from Board import Board" (wrong-import-order)
C:  7, 0: standard import "import os" comes before "from Board import Board" (wrong-import-order)
C:  8, 0: standard import "import time" comes before "from Board import Board" (wrong-import-order)
C:  9, 0: standard import "import copy" comes before "from Board import Board" (wrong-import-order)
C: 10, 0: standard import "import signal" comes before "from Board import Board" (wrong-import-order)
```

## Module Assignment3.new.Person
```
C: 46, 0: Unnecessary parens after 'while' keyword (superfluous-parens)
C:  1, 0: Missing module docstring (missing-docstring)
C: 12, 8: Invalid attribute name "y" (invalid-name)
C: 11, 8: Invalid attribute name "x" (invalid-name)
C:  9, 8: Invalid attribute name "upperPart" (invalid-name)
C: 10, 8: Invalid attribute name "lowerPart" (invalid-name)
C:  5, 0: Missing class docstring (missing-docstring)
R:  7, 4: Too many arguments (6/5) (too-many-arguments)
R:  5, 0: Too few public methods (0/2) (too-few-public-methods)
C: 15, 0: Missing class docstring (missing-docstring)
W: 18, 8: __init__ method from a non direct base class 'Person' is called (non-parent-init-called)
R: 15, 0: Too few public methods (0/2) (too-few-public-methods)
C: 21, 0: Missing class docstring (missing-docstring)
W: 24, 8: __init__ method from a non direct base class 'Person' is called (non-parent-init-called)
R: 21, 0: Too few public methods (0/2) (too-few-public-methods)
C: 28, 0: Missing class docstring (missing-docstring)
W: 31, 8: __init__ method from a non direct base class 'Person' is called (non-parent-init-called)
R: 28, 0: Too few public methods (0/2) (too-few-public-methods)
C: 40, 0: Invalid function name "EnemyArray" (invalid-name)
C: 40, 0: Invalid argument name "x" (invalid-name)
C: 40, 0: Invalid argument name "y" (invalid-name)
C: 40, 0: Missing function docstring (missing-docstring)
C: 44, 8: Invalid variable name "a" (invalid-name)
C: 45, 8: Invalid variable name "b" (invalid-name)
C: 47,12: Invalid variable name "a" (invalid-name)
C: 48,12: Invalid variable name "b" (invalid-name)
R:  1, 0: Similar lines in 2 files
```


# Report
467 statements analysed.

## Statistics by type
```
+---------+-------+-----------+-----------+------------+---------+
|type     |number |old number |difference |%documented |%badname |
+=========+=======+===========+===========+============+=========+
|module   |7      |NC         |NC         |14.29       |14.29    |
+---------+-------+-----------+-----------+------------+---------+
|class    |9      |NC         |NC         |0.00        |0.00     |
+---------+-------+-----------+-----------+------------+---------+
|method   |20     |NC         |NC         |40.00       |35.00    |
+---------+-------+-----------+-----------+------------+---------+
|function |6      |NC         |NC         |0.00        |33.33    |
+---------+-------+-----------+-----------+------------+---------+
```


## External dependencies

    termcolor (Assignment3.new.asciiDrawings,Assignment3.new.Board,Assignment3.new.game)



## Raw metrics
```
+----------+-------+------+---------+-----------+
|type      |number |%     |previous |difference |
+==========+=======+======+=========+===========+
|code      |509    |74.20 |NC       |NC         |
+----------+-------+------+---------+-----------+
|docstring |27     |3.94  |NC       |NC         |
+----------+-------+------+---------+-----------+
|comment   |10     |1.46  |NC       |NC         |
+----------+-------+------+---------+-----------+
|empty     |140    |20.41 |NC       |NC         |
+----------+-------+------+---------+-----------+
```


## Duplication

+-------------------------+------+---------+-----------+
|                         |now   |previous |difference |
+=========================+======+=========+===========+
|nb duplicated lines      |5     |NC       |NC         |
+-------------------------+------+---------+-----------+
|percent duplicated lines |0.744 |NC       |NC         |
+-------------------------+------+---------+-----------+



## Messages by category

+-----------+-------+---------+-----------+
|type       |number |previous |difference |
+===========+=======+=========+===========+
|convention |136    |NC       |NC         |
+-----------+-------+---------+-----------+
|refactor   |22     |NC       |NC         |
+-----------+-------+---------+-----------+
|warning    |26     |NC       |NC         |
+-----------+-------+---------+-----------+
|error      |6      |NC       |NC         |
+-----------+-------+---------+-----------+



% errors / warnings by module
-----------------------------

+------------------------------+------+--------+---------+-----------+
|module                        |error |warning |refactor |convention |
+==============================+======+========+=========+===========+
|Assignment3.new.game          |50.00 |26.92   |9.09     |30.88      |
+------------------------------+------+--------+---------+-----------+
|Assignment3.new.Board         |33.33 |34.62   |40.91    |25.74      |
+------------------------------+------+--------+---------+-----------+
|Assignment3.new.Bomb          |16.67 |26.92   |4.55     |6.62       |
+------------------------------+------+--------+---------+-----------+
|Assignment3.new.Person        |0.00  |11.54   |27.27    |13.24      |
+------------------------------+------+--------+---------+-----------+
|Assignment3.new.Block         |0.00  |0.00    |18.18    |11.76      |
+------------------------------+------+--------+---------+-----------+
|Assignment3.new.asciiDrawings |0.00  |0.00    |0.00     |11.76      |
+------------------------------+------+--------+---------+-----------+



Messages
--------

+-----------------------------+------------+
|message id                   |occurrences |
+=============================+============+
|invalid-name                 |56          |
+-----------------------------+------------+
|missing-docstring            |33          |
+-----------------------------+------------+
|line-too-long                |23          |
+-----------------------------+------------+
|unused-import                |10          |
+-----------------------------+------------+
|wrong-import-order           |7           |
+-----------------------------+------------+
|mixed-indentation            |6           |
+-----------------------------+------------+
|import-error                 |6           |
+-----------------------------+------------+
|too-many-nested-blocks       |5           |
+-----------------------------+------------+
|too-few-public-methods       |5           |
+-----------------------------+------------+
|bad-continuation             |4           |
+-----------------------------+------------+
|superfluous-parens           |3           |
+-----------------------------+------------+
|singleton-comparison         |3           |
+-----------------------------+------------+
|non-parent-init-called       |3           |
+-----------------------------+------------+
|bare-except                  |3           |
+-----------------------------+------------+
|bad-whitespace               |3           |
+-----------------------------+------------+
|unused-argument              |2           |
+-----------------------------+------------+
|too-many-statements          |2           |
+-----------------------------+------------+
|too-many-return-statements   |2           |
+-----------------------------+------------+
|too-many-instance-attributes |2           |
+-----------------------------+------------+
|too-many-branches            |2           |
+-----------------------------+------------+
|no-self-use                  |2           |
+-----------------------------+------------+
|consider-using-enumerate     |2           |
+-----------------------------+------------+
|ungrouped-imports            |1           |
+-----------------------------+------------+
|too-many-arguments           |1           |
+-----------------------------+------------+
|redefined-outer-name         |1           |
+-----------------------------+------------+
|pointless-statement          |1           |
+-----------------------------+------------+
|missing-final-newline        |1           |
+-----------------------------+------------+
|duplicate-code               |1           |
+-----------------------------+------------+



Global evaluation
-----------------
Your code has been rated at 5.42/10

