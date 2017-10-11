# Dir structure 
```
.
├── class_structure.dot
├── class_structure.svg
├── new
│   ├── board.py
│   ├── codereview.pdf
│   ├── config.py
│   ├── __init__.py
│   ├── main.py
│   ├── new_config.md
│   ├── objects.py
│   ├── people.py
│   ├── __pycache__
│   │   ├── board.cpython-36.pyc
│   │   ├── config.cpython-36.pyc
│   │   ├── objects.cpython-36.pyc
│   │   └── people.cpython-36.pyc
│   ├── README.md
│   └── requirements.txt
├── old
│   ├── board.py
│   ├── codereview.pdf
│   ├── config.py
│   ├── config.pyc
│   ├── __init__.py
│   ├── __init__.pyc
│   ├── main.py
│   ├── objects.py
│   ├── old_config.md
│   ├── people.py
│   ├── people.pyc
│   ├── __pycache__
│   │   ├── board.cpython-35.pyc
│   │   ├── board.cpython-36.pyc
│   │   ├── config.cpython-35.pyc
│   │   ├── config.cpython-36.pyc
│   │   ├── __init__.cpython-35.pyc
│   │   ├── objects.cpython-35.pyc
│   │   ├── objects.cpython-36.pyc
│   │   ├── people.cpython-35.pyc
│   │   └── people.cpython-36.pyc
│   ├── README.md
│   ├── requirements.txt
│   └── tests
│       ├── __init__.py
│       ├── __init__.pyc
│       ├── __pycache__
│       │   ├── __init__.cpython-35.pyc
│       │   ├── test_bomberman.cpython-27-PYTEST.pyc
│       │   ├── test_bomberman.cpython-35-PYTEST.pyc
│       │   ├── test_enemy.cpython-27-PYTEST.pyc
│       │   ├── test_enemy.cpython-35-PYTEST.pyc
│       │   ├── test_objects.cpython-27-PYTEST.pyc
│       │   ├── test_objects.cpython-35-PYTEST.pyc
│       │   ├── test_person.cpython-27-PYTEST.pyc
│       │   └── test_person.cpython-35-PYTEST.pyc
│       ├── test_bomberman.py
│       ├── test_enemy.py
│       └── test_objects.py
├── package_structure.dot
├── package_structure.svg
├── README.md
├── README.pdf
├── setup.py
├── structure.md
├── tetris
│   ├── Answer.txt
│   ├── block.py
│   ├── block.pyc
│   ├── board.py
│   ├── board.pyc
│   ├── gameplay.py
│   ├── gameplay.pyc
│   ├── __pycache__
│   │   └── block.cpython-35.pyc
│   ├── README
│   └── tests
│       ├── __init__.py
│       ├── __init__.pyc
│       ├── __pycache__
│       │   ├── test_block.cpython-27-PYTEST.pyc
│       │   ├── test_block.cpython-35-PYTEST.pyc
│       │   ├── test_board.cpython-27-PYTEST.pyc
│       │   ├── test_board.cpython-35-PYTEST.pyc
│       │   ├── test_gameplay.cpython-27-PYTEST.pyc
│       │   └── test_gameplay.cpython-35-PYTEST.pyc
│       ├── test_block.py
│       ├── test_board.py
│       └── test_gameplay.py
└── tox.ini

10 directories, 79 files
''' 
    performs all the tests associated with the bomberman
    - Bomb placing and other object tests are performed in test_objects

'''
```
## Sample test file (python3)

```

from importlib import reload
import os
import sys
if 'tests' in os.getcwd():
    sys.path.insert(0, os.path.join(os.getcwd(), '../'))
elif 'old' not in os.getcwd():
    sys.path.insert(0, os.path.join(os.getcwd(), './old/'))
try:
    import numpy as np
except ImportError:
    print("Numpy required")

import config
import people
import board

b = people.Bomber(5, 3)
bd = board.Board(34, 76, 1)


class Test_Bomberman:

    """ This class tests bomber and other enemy functionality
            involves people module
    """

    def test_numpy(self):
        ''' sample test to check numpy import '''
        try:
            import numpy as np
            assert isinstance(np.random.rand(2, 3), np.ndarray)
        except ImportError:
            assert False

    
    def test_init(self):
        ''' test initialization of bomber '''
        assert b.get_coords() == (5, 3)

    
    def test_bombs(self):
        ''' number of bombs '''
        assert b.bombs == config.bombs[1]
```
## Tox and other file 
[tox]
envlist=py35, py27
skipsdist=True

[testenv:py35]
deps=numpy
	pytest
commands=py.test --fulltrace old/tests

[testenv:py27]
deps=pytest
	pytest-timeout
commands=py.test --fulltrace tetris/tests
from setuptools import setup

setup(
	setup_requires = ['pytest-runner'],
	tests_require = ['pytest']
	)