defmodule Memory.Game do
  def new do
    %{
      tiles: next_set(),
      firstPick: 0,
      secondPick: 0,
      correctState: false,
      clicks: 0,
    }
  end
  def next_set() do
    ["A","B","C","D","E","F","G","H","A","B","C","D","E","F","G","H"]
    |> Enum.shuffle()
    |> Enum.map(fn x -> %{ value: x, opened: false, r: 0, c: 0, done: false } end)
    |> Enum.chunk_every(4)
    |> updatetiles()
  end

  def updatetiles(new_list) do
    for i <- 0..3 do
      for j <- 0..3 do
        Map.replace!(Enum.at(Enum.at(new_list,i),j), :r, i)
            |> Map.replace!( :c, j)
      end
    end
  end


  def client_view(game) do
    %{
    skel: game[:tiles],
    count: game.clicks,
    }
  end


  def play(game,tile) do
    IO.puts("hey there");
    row = tile["r"];
    col = tile["c"];
    newgame = if (Enum.at(Enum.at(game[:tiles],row),col)[:opened]) == false do
      IO.puts("in if");
      cond do
        (game[:firstPick] == 0) ->
            IO.puts("first pick")
            newclicks = game[:clicks] + 1;
            new_tile = Map.replace!(Enum.at(Enum.at(game[:tiles],row),col), :opened, true)
            tile2 = Enum.at(game[:tiles],row)
                    |> List.replace_at(col,new_tile)
            game = Map.replace!(game, :tiles, List.replace_at(game[:tiles],row,tile2))
              |> Map.replace!(:clicks , newclicks)
              |> Map.replace!(:firstPick , tile)
        (game[:secondPick] == 0) ->
            IO.puts("second pick")
            newclicks = game[:clicks] + 1;
            new_tile = Map.replace!(Enum.at(Enum.at(game[:tiles],row),col), :opened, true)
            tile2 = Enum.at(game[:tiles],row)
                    |> List.replace_at(col,new_tile)
            # tiles = List.replace_at(game[:tiles],row,tile2)
            game = Map.replace!(game, :tiles, List.replace_at(game[:tiles],row,tile2))
              |> Map.replace!( :clicks , newclicks)
              |> Map.replace!(:secondPick , tile)
            # checkCorrectness(game)
        true -> game
      end
    end
    game
  end

  def checkCorrectness(game) do
    val1 = game[:firstPick]
    val2 = game[:secondPick]
    game = if( String.equivalent?(val1["value"], val2["value"])) do
       Map.replace!(game, :correctState , true)
       :timer.sleep(500)
       markDone(game)
    else
      :timer.sleep(1000)
      IO.puts("going to flip")
      flipBack(game)
    end
    IO.puts("going to reset")
    game = resetBoard(game)
  end

  def markDone(game) do
    row1 = (game[:firstPick])["r"]
    col1 = (game[:firstPick])["c"]
    row2 = (game[:secondPick])["r"]
    col2 = (game[:secondPick])["c"]
    new_tile1 = Map.replace!(Enum.at(Enum.at((game[:tiles]),row1),col1),:done,true)
    tile1 = Enum.at(game[:tiles],row1)
            |> List.replace_at(col1,new_tile1)
    tiles1 = List.replace_at(game[:tiles],row1,tile1)
    game = Map.replace!(game, :tiles, tiles1)
    new_tile2 = Map.replace!(Enum.at(Enum.at((game[:tiles]),row2),col2),:done,true)
    tile2 = Enum.at(game[:tiles],row2)
            |> List.replace_at(col2,new_tile2)
    tiles2 = List.replace_at(game[:tiles],row2,tile2)
    game = Map.replace!(game, :tiles, tiles2)
    game
  end

  def flipBack(game) do
    row1 = (game[:firstPick])["r"]
    col1 = (game[:firstPick])["c"]
    row2 = (game[:secondPick])["r"]
    col2 = (game[:secondPick])["c"]
    IO.puts("inflipback")
    new_tile1 = Map.replace!(Enum.at(Enum.at((game[:tiles]),row1),col1),:opened,false)
    tile1 = Enum.at(game[:tiles],row1)
            |> List.replace_at(col1,new_tile1)
    tiles1 = List.replace_at(game[:tiles],row1,tile1)
    game = Map.replace!(game, :tiles, tiles1)
    new_tile2 = Map.replace!(Enum.at(Enum.at((game[:tiles]),row2),col2),:opened,false)
    tile2 = Enum.at(game[:tiles],row2)
            |> List.replace_at(col2,new_tile2)
    tiles2 = List.replace_at(game[:tiles],row2,tile2)
    game = Map.replace!(game, :tiles, tiles2)
    game
  end

  def resetBoard(game) do
    Map.replace!(game, :firstPick, 0)
    |> Map.replace!(:secondPick, 0)
    |> Map.replace!(:correctState, false)
  end

  def resetGame(game) do
    game.new()
  end

end



# References:
# https://hexdocs.pm/phoenix/channels.html
# https://elixirforum.com
# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/09-websockets/notes.html
# https://github.com/NatTuck/hangman2
