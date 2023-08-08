function nimSum(board)
    sum = 0
    for i in eachindex(board)
        sum ⊻= board[i]
    end
    return sum
end

function isGoodMove(board,move)
    if nimSum(board - move) == 0
        return true
    end
    return false
end

board = [7,5,3]
for i in eachindex(board)
    num_moves = board[i]
    move = [0,0,0]
    for _ in range(1,num_moves)
        move[i] += 1
        if isGoodMove(board,move)
            print("board before move: ", board)
            for i in range(1,length(board))
                board[i] -= move[i]
            end
            print(" board after move: ", board)
            break
        end
    end
end

