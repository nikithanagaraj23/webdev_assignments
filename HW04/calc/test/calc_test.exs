defmodule CalcTest do
  use ExUnit.Case
  doctest Calc
  test "test Sum" do
    assert Calc.eval("2 + 3") == 5
  end
  test "test Multiply" do
    assert Calc.eval("5 * 1") == 5
  end
  test "test Divide" do
    assert Calc.eval("20 / 4") == 5
  end
  test "test Paranthesis" do
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
  end
  test "test Parenthesis" do
    assert Calc.eval("24 / (6 + (5 - 4))") == 3
  end
  test "test Precedence 2" do
    assert Calc.eval("20 / 4 + 3") == 8
  end
  test "test Precedence 3" do
    assert Calc.eval("20 / 4 + 3 * 10") == 35
  end
  test "test Precedence 4" do
    assert Calc.eval("20 * 4 + 3") == 83
  end
  test "test Subtract" do
    assert Calc.eval("20 - 4") == 16
  end
  test "test multiple calculations" do
    assert Calc.eval("20 - 4 + 1 * 40 / 3") == 29
  end
  test "test multiple parenthesis" do
    assert Calc.eval("24 / 6 + (5 - 4) + (3 + 6)") == 14
  end
  test "test multiple parenthesis with recursion" do
    assert Calc.eval(" 24 / 6 + (5 - 4) + (3 + 6) + (6 + (5 - 4))") == 21
  end
  test "test PatternMatch" do
    assert Calc.patternMatch("20 - 4","20 - 4") == 16
  end
  test "test paranthesisFinder" do
    assert Calc.paranthesisFinder("(20 - 4)") == false
  end

  test "test Tokenize" do
    assert Calc.tokenize("20 - 4") == 16
  end
  test "test getNums" do
    assert Calc.getNums("20") == 20
  end
  test "test getPrecendence" do
    assert Calc.getPrecedence("*","+") == false
  end
  test "test populateStacks" do
    assert Calc.populateStacks([2,"+",4]) == 6
  end
  test "test calculate" do
    assert Calc.calculate(["*"],[2,4]) == 8
  end
  test "test updateStack" do
    assert Calc.updateStack(["*"],[2,4],1 ,1) == 8
  end
  test "test exhaustList" do
    assert Calc.exhaustList(["+"],[2,10],1 ,1) == 12
  end
  test "test get_op" do
    assert Calc.get_op("+",20,10) == 30
  end
  test "test add" do
    assert Calc.add(20,10) == 30
  end
  test "test subtract" do
    assert Calc.sub(20,10) == 10
  end
  test "test multiply" do
    assert Calc.mul(20,10) == 200
  end
  test "test divide" do
    assert Calc.division(20,10) == 2
  end










end
