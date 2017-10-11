from ..block import block
from ..gameplay import gameEnv

g = gameEnv()

class Test_Block():

    def test_rotate_block(self):
        #block = g.getNewBlock("X")
        block = g.tetrisPieces[0]
        new_block = g.rotateBlock(block, 4, 5)
        test_block = [
                    [1,0],
                    [1,1],
                    [0,1]
                    ]
        assert test_block == new_block 
        block = g.tetrisPieces[1]
        new_block = g.rotateBlock(block, 4, 5)
        test_block = [
                    [1],
                    [1],
                    [1],
                    [1]
                    ]
        assert test_block == new_block 
        block = g.tetrisPieces[2]
        new_block = g.rotateBlock(block, 4, 5)
        test_block = [
                    [0,1],
                    [1,1],
                    [1,0]
                    ]
        assert test_block == new_block 
        block = g.tetrisPieces[3]
        new_block = g.rotateBlock(block, 4, 5)
        test_block = [
                    [1,1],
                    [1,1]
                    ]
        assert test_block == new_block 
        block = g.tetrisPieces[6]
        new_block = g.rotateBlock(block, 4, 5)
        test_block = [
                    [1,1],
                    [0,1],
                    [0,1]
                    ]
        assert test_block == new_block 
     
    def test_valid_rotate_block(self):
        block = g.tetrisPieces[1]
        new_block = g.rotateBlock(block, 28, 20)
        leg_block = 28+len(new_block)-1
        assert leg_block < g.h-1
        block = g.tetrisPieces[0]
        new_block = g.rotateBlock(block, 27, 20)
        leg_block = 27+len(new_block)-1
        assert leg_block < g.h-1
        block = g.tetrisPieces[2]
        new_block = g.rotateBlock(block, 27, 20)
        leg_block = 27+len(new_block)-1
        assert leg_block < g.h-1
        block = g.tetrisPieces[3]
        new_block = g.rotateBlock(block, 27, 20)
        leg_block = 27+len(new_block)-1
        assert leg_block < g.h-1